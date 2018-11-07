Return-Path: <SRS0=M7Bi=NS=gmail.com=himanshujha199640@kernel.org>
Date: Wed, 7 Nov 2018 15:18:08 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Chris Coffey <cmc@babblebit.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Peter Rosin <peda@axentia.se>, Slawomir Stepien <sst@poczta.fm>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: Add driver for Microchip
 MCP41xxx/42xxx
Message-ID: <20181107094808.GB25433@himanshu-Vostro-3559>
References: <20181106113130.9612-1-cmc@babblebit.net>
 <20181106154806.GB20842@himanshu-Vostro-3559>
 <20181107090550.ubwqr4sd2mo3sqwn@deb-660>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181107090550.ubwqr4sd2mo3sqwn@deb-660>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Nov 07, 2018 at 09:05:50AM +0000, Chris Coffey wrote:
> Thank you for the review. I have a question inline.
> 
> On Tue, Nov 06, 2018 at 09:18:06PM +0530, Himanshu Jha wrote:
> > On Tue, Nov 06, 2018 at 11:31:30AM +0000, Chris Coffey wrote:
> > > This patch adds driver support for the Microchip MCP41xxx/42xxx family
> > > of digital potentiometers:
> > > 
> > > DEVICE      Wipers  Positions   Resistance (kOhm)
> > > MCP41010    1       256         10
> > > MCP41050    1       256         50
> > > MCP41100    1       256         100
> > > MCP42010    2       256         10
> > > MCP42050    2       256         50
> > > MCP42100    2       256         100
> > > 
> > > Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
> > > 
> > > Signed-off-by: Chris Coffey <cmc@babblebit.net>
> > > ---
> > >  .../bindings/iio/potentiometer/mcp41010.txt        |  29 +++
> > 
> > WARNING: DT binding docs and includes should be a separate patch. 
> > See: Documentation/devicetree/bindings/submitting-patches.txt
> > 
> > Please run checkpatch.pl on this patch once.
> > 
> 
> Oops. I ran checkpatch.pl on the individual files, but neglected to run
> it on the patch file itself. I'll split the patch in v2.

No problem.

It is better for DT maintainers, and they get less spam. It was recent
effort by Rob IIRC,

"133712a2ec84 checkpatch: DT bindings should be a separate patch"

When you run on source file use `-f` flag and on patch just naked
run is fine.

> checkpatch.pl also reports a warning about the MAINTAINERS file:
> WARNING: added, moved or deleted file(s), does MAINTAINERS need
> updating?
> 
> ... but looking through the tree, many IIO drivers don't have
> corresponding entries in MAINTAINERS; is this one of those checkpatch
> warnings that can be safely ignored? Or should all new drivers have a
> corresponding entry in MAINTAINERS?

It's upto you actually. 
Not a necessity to be a maintainer.

But when you add your name to MAINTAINERS you would need to review the
patches sent on the driver and maybe test it too.

And if you're not sure, then leave it as-is!

Without the entry in MAINTAINERS too, you can review/test patches
sent on your driver(which is what I do ..)

Obligations! ;)

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
