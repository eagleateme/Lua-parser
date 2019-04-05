/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_LUA_TAB_H_INCLUDED
# define YY_YY_LUA_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    AND = 258,
    BREAK = 259,
    DO = 260,
    ELSE = 261,
    ELSEIF = 262,
    END = 263,
    FALSE = 264,
    FOR = 265,
    FUNCTION = 266,
    IF = 267,
    IN = 268,
    LOCAL = 269,
    NIL = 270,
    NOT = 271,
    OR = 272,
    REPEAT = 273,
    RETURN = 274,
    THEN = 275,
    TRUE = 276,
    UNTIL = 277,
    WHILE = 278,
    HASH = 279,
    BINOP = 280,
    EQUALS = 281,
    MINUS = 282,
    LB = 283,
    RB = 284,
    LFB = 285,
    RFB = 286,
    LSB = 287,
    RSB = 288,
    SEMICOLON = 289,
    COMMA = 290,
    COLON = 291,
    DOT = 292,
    VARDOT = 293,
    ID = 294,
    NUM = 295,
    STRING = 296,
    DOLLAR = 297
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_LUA_TAB_H_INCLUDED  */
