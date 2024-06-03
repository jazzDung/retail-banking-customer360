import React, { useState } from 'react';

const JsonViewer = ({ data }) => {
    const renderJson = (data, indentLevel = 0) => {
      if (typeof data === 'object' && data !== null) {
        const isArray = Array.isArray(data);
        return (
          <div style={{ paddingLeft: indentLevel * 20 }}>
            <span>{isArray ? '[' : '{'}</span>
            {Object.keys(data).map((key, index) => (
              <div key={index} style={{ paddingLeft: 20 }}>
                {!isArray && <span className="json-key">"{key}": </span>}
                {typeof data[key] === 'object' && data[key] !== null ? (
                  renderJson(data[key], indentLevel + 1)
                ) : (
                  <span className="json-value">{JSON.stringify(data[key])}</span>
                )}
                {index < Object.keys(data).length - 1 && ','}
              </div>
            ))}
            <span>{isArray ? ']' : '}'}</span>
          </div>
        );
      } else {
        return <span className="json-value">{JSON.stringify(data)}</span>;
      }
    };
  
    return <div className="json-viewer">{renderJson(data)}</div>;
  };
  
  export default JsonViewer;