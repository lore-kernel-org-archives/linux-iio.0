Return-Path: <robherring2@gmail.com>
Date: Sun, 30 Oct 2016 22:09:39 -0500
From: Rob Herring <robh@kernel.org>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: si7020: Add devicetree support and trivial bindings
Message-ID: <20161031030939.3q6jpuom7jxphl2o@rob-hp-laptop>
References: <20161025192010.11195-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161025192010.11195-1-contact@paulk.fr>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Oct 25, 2016 at 09:20:10PM +0200, Paul Kocialkowski wrote:
> This adds devicetree support for the si7020 iio driver. Since it works
> well without requiring any additional property, its compatible string is
> added to the trivial i2c devices bindings list.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt |  1 +
>  drivers/iio/humidity/si7020.c                             | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
