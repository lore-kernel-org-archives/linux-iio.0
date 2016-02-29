Return-Path: <shawnguo@kernel.org>
Date: Mon, 29 Feb 2016 11:23:42 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: maitysanchayan@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, stefan@agner.ch, pmeerw@pmeerw.net
Subject: Re: [PATCH v3 2/2] iio: dac: vf610_dac: Add IIO DAC driver for
 Vybrid SoC
Message-ID: <20160229032342.GR22051@tiger>
References: <cover.1456121233.git.maitysanchayan@gmail.com>
 <1a70acdd3ffae273bbfe2f80c5e3952d152921df.1456121233.git.maitysanchayan@gmail.com>
 <20160223205437.GA27366@rob-hp-laptop>
 <56CE18AC.6020603@kernel.org>
 <20160225153045.GA15913@Sanchayan-Arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160225153045.GA15913@Sanchayan-Arch>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Feb 25, 2016 at 09:00:45PM +0530, maitysanchayan@gmail.com wrote:
> Hello,
> 
> On 16-02-24 20:55:08, Jonathan Cameron wrote:
> > On 23/02/16 20:54, Rob Herring wrote:
> > > On Mon, Feb 22, 2016 at 11:48:37AM +0530, Sanchayan Maity wrote:
> > >> Add driver support for DAC peripheral on Vybrid SoC.
> > >>
> > >> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > >> ---
> > >>  Documentation/ABI/testing/sysfs-bus-iio-vf610      |   9 +
> > >>  .../devicetree/bindings/iio/dac/vf610-dac.txt      |  20 ++
> > > 
> > > For the binding:
> > > 
> > > Acked-by: Rob Herring <robh@kernel.org>
> > Applied to the togreg branch of iio.git - initially pushed out as testing
> > for the autobuilders to play with it.
> 
> Thanks Jonathan.
> 
> > 
> > Note the dts change probably wants to go via the relevant arch trees.
> > I can take it with an appropriate ack if not.
> 
> Generally shawn picks up the device tree changes once the driver makes
> it to his for-next branch. I will ping shawn to pick this up once the
> driver lands in shawn's for-next branch.

For such device enabling which does no harm on my tree, i.e. no
regression or breakage, I will be happy to take it once driver part gets
applied, so that we do not need to wait for another release cycle to
get it work.

I applied dts patch, thanks.

Shawn
