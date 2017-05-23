Return-Path: <SRS0=Vgs8=45=gmail.com=robherring2@kernel.org>
Date: Mon, 22 May 2017 19:31:42 -0500
From: Rob Herring <robh@kernel.org>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: as3935: add missing required
 spi-max-frequency
Message-ID: <20170523003142.spslp7wtnmcoex2o@rob-hp-laptop>
References: <20170517020310.21355-1-matt.ranostay@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170517020310.21355-1-matt.ranostay@konsulko.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 16, 2017 at 07:03:10PM -0700, Matt Ranostay wrote:
> spi-max-frequency is required to be set for the as3935 part, and
> document such usage.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  Documentation/devicetree/bindings/iio/proximity/as3935.txt | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Rob
