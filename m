Return-Path: <robherring2@gmail.com>
Date: Tue, 4 Oct 2016 08:44:35 -0500
From: Rob Herring <robh@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt: bindings: i2c/trivial-devices.txt: Add 2 iio
 supported accelerometers
Message-ID: <20161004134435.GB12103@rob-hp-laptop>
References: <20161002155135.23298-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161002155135.23298-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Oct 02, 2016 at 05:51:34PM +0200, Hans de Goede wrote:
> Add compatible strings for 2 accelerometers which follow the trivial
> i2c device bindings and have been supported by the iio subsystem for
> a while now.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
