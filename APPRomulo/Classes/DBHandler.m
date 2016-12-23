//
//  DBHandler.m
//  BancoDeDados
//
//  Created by Denis Nascimento on 06/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DBHandler.h"


@implementation DBHandler
static DBHandler * instancia=NULL;//armazena a instancia do DBHandler
static sqlite3 * database;//instancia do banco

+(DBHandler*)shared{
	if (instancia==NULL) {
		//inicio o banco se ele ainda nao existe
		instancia = [[DBHandler alloc]init];

		if(sqlite3_open([OJORNALEIRODBFile UTF8String], &database)!=SQLITE_OK){
			NSLog(@"falha ao abrir o banco");
		}else{
      NSLog(@"Banco aberto");
    }
	}
	return instancia;
  
}
-(sqlite3_stmt*)runSQL:(NSString*)sql{
	
	sqlite3_stmt * resposta;//armazena o resultado da consulta
	char *err;//armazena erros(nao usaremos)
	
	const char *csql = [sql cStringUsingEncoding:NSUTF8StringEncoding];
	//transforma a query de OBJC para C
	
	//prepara nosso comando e avisa se tem erro de sintaxe
	if (sqlite3_prepare(database, csql, -1, &resposta, NULL)!=SQLITE_OK) {
		NSLog(@"Erro no prepare:%s",sqlite3_errmsg(database));
		return nil;
	}
	//executa a query de fato
	if (sqlite3_exec(database, csql, nil, &resposta, &err) == SQLITE_OK) {
		return resposta;
	}else {
		NSLog(@"falha no exec:%s",sqlite3_errmsg(database));
		return nil;
	}	
}
-(void)runScript:(NSString*)filename
{
  
  NSError *error;
	NSString * path=[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:filename];
	NSString *conteudo=[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error ];	
	
	[self runSQL:conteudo];

}

+(NSString*)cStringToOBJC:(const char *)cString{
  
 // NSLog(@"cString:%@",[NSString stringWithCString:cString encoding:NSUTF8StringEncoding]);
  
  if (cString ==nil) {
    return @"";
  }
	return [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
}



@end
