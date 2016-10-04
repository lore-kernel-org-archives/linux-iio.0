Return-Path: <robherring2@gmail.com>
Date: Tue, 4 Oct 2016 08:44:01 -0500
From: Rob Herring <robh@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt: bindings: vendor-prefix: Add 3 accelerometer
 vendor prefixes
Message-ID: <20161004134401.GA12103@rob-hp-laptop>
References: <20161002155135.23298-1-hdegoede@redhat.com>
 <20161002155135.23298-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161002155135.23298-2-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Oct 02, 2016 at 05:51:35PM +0200, Hans de Goede wrote:
> Recently the kernel has gotten support in the iio subsystem for a number
> of new accelerometers from Domintech, mCube, Memsic and MiraMEMS.
> 
> This commit adds the vendor prefixes already used for these vendors
> in Documentation/devicetree/bindings/i2c/trivial-devices.txt to
> vendor-prefixes.txt.
> 
> Domintech's full company name was taken from copyright headers for
> their drivers from: https://github.com/domintech/
> 
> The other full company names were taken from the company's websites:
> http://www.mcubemems.com/
> http://www.memsic.com/
> http://www.miramems.com/en/
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 4 ++++
>  1 file changed, 4 insertions(+)

I've applied this one to avoid any conflicts with sorting 
vendor-prefixes.txt. I fixed up the sorting of mcube.

Patch 1 conflicts with Jonathan's tree, so I'll let him take it.

Rob
