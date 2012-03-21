a::#d:
#define 
a::#u:
#undef 
a::#p:
#pragma 
a::#in:
#include "$end$"
a::#in:
#include <$end$>
a::#im:
#import "$end$"
a::#im:
#import <$end$>
a:#ifdef ... #endif:#if:
#ifdef $end$
$selected$
#endif
a:#if 0 ... #endif:#if:
#if 0
$selected$$end$
#endif
a:#ifndef ... #endif:#ifn:
#ifndef $end$
$selected$
#endif
a::#e:
#else
a::#en:
#endif
a::A:
ASSERT($end$)
a::b:
bool
a::DW:
DWORD
a::r:
return
a::fl:
float
a::HA:
HANDLE
a::HI:
HINSTANCE
a::HR:
HRESULT
a::H:
HWND
a::ll:
long long
a::LP:
LPARAM
a::LPB:
LPBYTE
a::LPC:
LPCTSTR
a::LPT:
LPTSTR
a::LR:
LRESULT
a::TC:
TCHAR
a::U:
UINT
a::ui:
unsigned int
a::ul:
unsigned long
a::UL:
ULONG
a::W:
WORD
a::WP:
WPARAM
a::N:
NULL
a::nn:
!= NULL
a::n0:
!= 0
a:GUID IMPLEMENT_OLECREATE:guid:
// {$GUID_STRING$} 
IMPLEMENT_OLECREATE($GUID_Class$, $GUID_ExternalName$, 
$GUID_DEFINITION$);

a:DEFINE_GUID:guid:
// {$GUID_STRING$} 
DEFINE_GUID($GUID_Name$, 
$GUID_DEFINITION$);

a:GUID struct instance:guid:
// {$GUID_STRING$} 
static const GUID $GUID_InstanceName$ = 
{ $GUID_STRUCT$ };

a:GUID string:guid:
"{$GUID_STRING$}"
a:IDL uuid:uuid:
uuid($GUID_STRING$)
a::usi:
using namespace $end$;

a::class:
class $end$
{
public:
protected:
private:
};

a:class with prompt for name:class:
class $Class_name$
{
public:
	$Class_name$();
	~$Class_name$();
protected:
	$end$
private:
};

a:dynamic cast, run code on valid cast:dyna:
$New_type$ *$New_pointer$ = dynamic_cast<$New_type$ *>($Cast_this$);
if (NULL != $New_pointer$)
{
	$end$
}

a::struct:
struct $end$ 
{
};

a::switch:
switch ($end$)
{
	$selected$
}

a::switch:
switch ($end$)
{
case :
	break;
}

a:://-:
// $end$ [$MONTH$/$DAY$/$YEAR$ %USERNAME%]
a::///:
//////////////////////////////////////////////////////////////////////////

a::/*-:
/*
 *	$end$
 */
a::/**:
/************************************************************************/
/* $end$                                                                     */
/************************************************************************/
a:atoi(...)::
atoi($selected$)$end$
a:_T(...)::
_T($selected$)$end$
a:_T():tc:
_T($end$)
a:if () { ... }:if:
if ($end$)
{
	$selected$
}

a:if () { ... } else { }:if:
if ($end$)
{
	$selected$
} 
else
{
}

a:if () { } else { ... }::
if ($end$)
{
} 
else
{
	$selected$
}

a:while () { ... }:while:
while ($end$)
{
	$selected$
}

a:for () { ... }:for:
for ($end$)
{
	$selected$
}

a:for loop forward:forr:
for (int $Index$ = 0; $Index$ < $Length$ ; $Index$++)
{
	$end$
}

a:for loop reverse:forr:
for (int $Index$ = $Length$ - 1; $Index$ >= 0 ; $Index$--)
{
	$end$
}

a:do { ... } while ():do:
do 
{
	$selected$
} while ($end$);

a:try { ... } catch {} catch {} catch {}:try:
try
{
	$selected$
}
catch (CMemoryException* e)
{
	$end$
}
catch (CFileException* e)
{
}
catch (CException* e)
{
}

a:TRY { ... } CATCH {}:TRY:
TRY 
{
	$selected$
}
CATCH (CMemoryException, e)
{
	$end$
}
END_CATCH

a::bas:
$BaseClassName$::$MethodName$($MethodArgs$);


a::sup:
__super::$MethodName$($MethodArgs$);


a:#ifdef guard in a header:once:
#ifndef $FILE_BASE$_h__
#define $FILE_BASE$_h__

$selected$
#endif // $FILE_BASE$_h__

a:File header detailed:header:
/**
  @file    $FILE_BASE$.$FILE_EXT$
  @author  »ªÁÁ [ Cedric Porter ]
  @version 0.1
  @date    $DATE$
  @brief   
 
 */

a:Win32 standard application::
#include <windows.h>
LRESULT CALLBACK WndProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
int WINAPI WinMain (HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR szCmdLine, int iCmdShow)
{
    static TCHAR szAppName[] = TEXT ("$end$");
    HWND         hwnd;
    MSG          msg;
    WNDCLASSEX   wndclassex = {0};
    wndclassex.cbSize        = sizeof(WNDCLASSEX);
    wndclassex.style         = CS_HREDRAW | CS_VREDRAW;
    wndclassex.lpfnWndProc   = WndProc;
    wndclassex.cbClsExtra    = 0;
    wndclassex.cbWndExtra    = 0;
    wndclassex.hInstance     = hInstance;
    wndclassex.hIcon         = LoadIcon (NULL, IDI_APPLICATION);
    wndclassex.hCursor       = LoadCursor (NULL, IDC_ARROW);
    wndclassex.hbrBackground = (HBRUSH) GetStockObject (WHITE_BRUSH);
    wndclassex.lpszMenuName  = NULL;
    wndclassex.lpszClassName = szAppName;
    wndclassex.hIconSm       = wndclassex.hIcon;
	
    if (!RegisterClassEx (&wndclassex))
    {
        MessageBox (NULL, TEXT ("RegisterClassEx failed!"), szAppName, MB_ICONERROR);
        return 0;
    }
    hwnd = CreateWindowEx (WS_EX_OVERLAPPEDWINDOW, 
		                  szAppName, 
        		          TEXT ("WindowTitle"),
                		  WS_OVERLAPPEDWINDOW,
		                  CW_USEDEFAULT, 
        		          CW_USEDEFAULT, 
                		  CW_USEDEFAULT, 
		                  CW_USEDEFAULT, 
        		          NULL, 
                		  NULL, 
		                  hInstance,
        		          NULL); 
						  
    ShowWindow (hwnd, iCmdShow);
    UpdateWindow (hwnd);
	
    while (GetMessage (&msg, NULL, 0, 0))
    {
        TranslateMessage (&msg);
        DispatchMessage (&msg);
    }
    return msg.wParam;
}
LRESULT CALLBACK WndProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    HDC hdc;
    PAINTSTRUCT ps;
    switch (message)
    {
    case WM_CREATE:
        return (0);
		
    case WM_PAINT:
        hdc = BeginPaint (hwnd, &ps);
        TextOut (hdc, 0, 0, "A Window!", 27);
        EndPaint (hwnd, &ps);
        return (0);
		
    case WM_DESTROY:
        PostQuitMessage (0);
        return (0);
    }
    return DefWindowProc (hwnd, message, wParam, lParam);
}

a:Dialog procedure::
BOOL CALLBACK $end$ (HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
	switch(message)
	{
	case WM_INITDIALOG:
        {
			
        }
		return (TRUE);
	case WM_CLOSE:
        {
            EndDialog(hDlg,0);
        }
		return (TRUE);
	case WM_COMMAND:
		switch (LOWORD(wParam))
		{
		case IDCANCEL:
            {
                SendMessage(hDlg, WM_CLOSE, 0, 0);
            }
            return (TRUE);
		case IDOK:
            {
                
            }
			return (TRUE);
		}
		return (FALSE);
	}
	return (FALSE);
}

a:Window procedure::
LRESULT CALLBACK $end$ (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    HDC hdc;
    PAINTSTRUCT ps;
    switch (message)
    {
    case WM_CREATE:
        return (0);
		
    case WM_PAINT:
        hdc = BeginPaint (hwnd, &ps);
        
        EndPaint (hwnd, &ps);
        return (0);
		
    case WM_DESTROY:
        PostQuitMessage (0);
        return (0);
    }
    return DefWindowProc (hwnd, message, wParam, lParam);
}

readme:
VA Snippet used for suggestions in loops.
Delete this item to restore the default upon next use.

a:SuggestionsForType loop::
continue;
break;

readme:
VA Snippet used for suggestions in switch statements.
Delete this item to restore the default upon next use.

a:SuggestionsForType switch::
case 
default:
break;

readme:
VA Snippet used for suggestions in class definitions.
Delete this item to restore the default upon next use.

a:SuggestionsForType class::
public:
private:
protected:
virtual
void
bool
string
static
const

readme:
VA Snippet used for suggestions of type bool.
Delete this item to restore the default upon next use.

a:SuggestionsForType bool::
true
false

readme:
VA Snippet used for suggestions of type BOOL.
Delete this item to restore the default upon next use.

a:SuggestionsForType BOOL::
TRUE
FALSE

readme:
VA Snippet used for suggestions of type HRESULT.
Delete this item to restore the default upon next use.

a:SuggestionsForType HRESULT::
S_OK
S_FALSE

readme:
VA Snippet used for suggestions of type VARIANT_BOOL.
Delete this item to restore the default upon next use.

a:SuggestionsForType VARIANT_BOOL::
VARIANT_TRUE
VARIANT_FALSE

readme:
VA Snippet used for refactoring: Change Signature, Create Implementation, and Move Implementation to Source File.
Delete this item to restore the default upon next use.

a:Refactor Create Implementation::

$SymbolType$ $SymbolContext$( $ParameterList$ ) $MethodQualifier$
{
	$end$$MethodBody$
}


readme:
VA Snippet used for refactoring.
Delete this item to restore the default upon next use.

a:Refactor Document Method::
/** $end$  
  @remarks 
  @param   $MethodArgName$ 
  @return    
 */

readme:
VA Snippet used for refactoring.
Delete this item to restore the default upon next use.

a:Refactor Encapsulate Field::
	$end$$SymbolType$ $GeneratedPropertyName$() const { return $SymbolName$; }
	void $GeneratedPropertyName$($SymbolType$ val) { $SymbolName$ = val; }

readme:
VA Snippet used for refactoring.
Delete this item to restore the default upon next use.

a:Refactor Extract Method::

$end$$SymbolType$ $SymbolContext$( $ParameterList$ ) $MethodQualifier$
{
	$MethodBody$
}


readme:
VA Snippet used for refactoring.
Delete this item to restore the default upon next use.

a:Refactor Create From Usage Method Body::
throw std::exception("The method or operation is not implemented.");
readme:
VA Snippet used by Surround With #ifdef.
Delete this item to restore the default upon next use.

a:#ifdef (VA X):#if:
#ifdef $condition=_DEBUG$$end$
$selected$
#endif // $condition$

readme:
VA Snippet used by Surround With #region.
Delete this item to restore the default upon next use.

a:#region (VA X):#r:
#pragma region $end$$regionName$
$selected$
#pragma endregion $regionName$

readme:
Delete this item to restore the default when the IDE starts.

a:{...}::
{
	$end$$selected$
}

readme:
Delete this item to restore the default when the IDE starts.

a:(...)::
($selected$)
readme:
VA Snippet used for suggestions of type HANDLE.
Delete this item to restore the default upon next use.

a:SuggestionsForType HANDLE::
INVALID_HANDLE_VALUE
NULL

