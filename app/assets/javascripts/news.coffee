jQuery ->
  markdownSettings = {
    previewParserPath: '/markdown/preview'
    onShiftEnter:	{keepDefault:false, openWith:'\n\n'}
    markupSet: [
      {
        name:'First Level Heading', key:'1',
        placeHolder:'Your title here...',
        closeWith: (markItUp) -> markdownTitle(markItUp, '=')
      },
      {
        name:'Second Level Heading', key:'2', placeHolder:'Your title here...',
        closeWith: (markItUp) -> markdownTitle(markItUp, '-')
      },
      {name:'Heading 3', key:'3', openWith:'### ', placeHolder:'Your title here...' }
      {name:'Heading 4', key:'4', openWith:'#### ', placeHolder:'Your title here...' }
      {name:'Heading 5', key:'5', openWith:'##### ', placeHolder:'Your title here...' }
      {name:'Heading 6', key:'6', openWith:'###### ', placeHolder:'Your title here...' }
      {separator:'---------------' }
      {name:'Bold', key:'B', openWith:'**', closeWith:'**'}
      {name:'Italic', key:'I', openWith:'_', closeWith:'_'}
      {separator:'---------------' }
      {name:'Bulleted List', openWith:'- ' }
      {name:'Numeric List', openWith: (markItUp) -> markItUp.line+'. ' }
      {separator:'---------------' }
      {
        name:'Picture', key:'P',
        replaceWith:'![[![Alternative text]!]]([![Url:!:http://]!] "[![Title]!]")'
      },
      {
        name:'Link', key:'L', openWith:'[',
        closeWith:']([![Url:!:http://]!] "[![Title]!]")',
        placeHolder:'Your text to link here...'
      },
      {separator:'---------------'},
      {name:'Quotes', openWith:'> '}
      {name:'Code Block / Code', openWith:'(!(\t|!|`)!)', closeWith:'(!(`)!)'}
      {separator:'---------------'}
      {name:'Preview', call:'preview', className:"preview"}
    ]
  }

  markdownTitle = (markItUp, char) ->
    heading = '';
    n = $.trim(markItUp.selection||markItUp.placeHolder).length;
    for i in [0..n]
      heading += char
    '\n'+heading

  $('#news_body').markItUp(markdownSettings)