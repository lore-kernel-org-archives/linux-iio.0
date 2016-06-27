Return-Path: <linux@roeck-us.net>
Date: Mon, 27 Jun 2016 13:40:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-hwmon@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: MCP9808 iio or hwmon
Message-ID: <20160627204058.GB5891@roeck-us.net>
References: <20160613220843.GA4235@d830.WORKGROUP>
 <CAEnQRZBZcQZRYGbk-6Eh5sN7_D90HTZPPo=uOSSZF2obB5VD+w@mail.gmail.com>
 <CAEnQRZC9ES6dGyUdycW=nRuA=6yRa=i01BWBLt7uFsieE-74OQ@mail.gmail.com>
 <57600656.7030902@roeck-us.net>
 <20160621222609.GA2464@d830.WORKGROUP>
 <20160621234246.GA23912@roeck-us.net>
 <20160625003656.GA2726@d830.WORKGROUP>
 <576DE861.8050905@roeck-us.net>
 <20160627191317.GA4530@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160627191317.GA4530@d830.WORKGROUP>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jun 27, 2016 at 12:13:19PM -0700, Alison Schofield wrote:

[ ... ]

> > 
> > Great. Can you send a patch for the jc42 driver ?
> > 
> > Thanks,
> > Guenter
> > 
> Guenther,
> 
> I have the patch, but am stumbling on the changelog.
> 
> I hoped to simply state in the changelog that MCP9808 is a jc-42
> compliant sensor, but I don't think it's 100% true, and I'm not
> sure of where it falls short of compliance.
> 
> jc42 currently supports these Microchip sensors:
> MCP9804, MCP9805, MCP98242, MCP98243, MCP98244, MCP9843
> 
> All, with the exception of 9804 (and my 9808), clearly state they
> are jc-42 compliant in their datasheet.
> 
> 9804 is 9808's twin and I've tested with 9808.
> 
> Wondering if the non-compliance has to do with the lack of a capability
> register for 9804 & 9808, which doesn't affect the drivers functioning.
> 

The capabilities register is there, it is just not officially supported.
It does report useful values, though, at least as far as we need it.
The chip does have a resolution register, which doesn't exist in JC-42.

"
hwmon: (jc42) Add support for Microchip MCP9808

MCP9808 is not officially compliant to JC-42, similar to MCP9804,
but its registers are compatible to JC-42.
"

is good enough. If you want to be fancy, add "The sensor resolution
register is not currently supported".

Hope this helps,

Guenter
