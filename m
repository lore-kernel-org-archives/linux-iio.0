Return-Path: <SRS0=TDmA=HF=gmail.com=robherring2@kernel.org>
Date: Mon, 16 Apr 2018 16:43:55 -0500
From: Rob Herring <robh@kernel.org>
To: Fabian Mewes <architekt@coding4coffee.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Rutland <mark.rutland@arm.com>, Lukas Wunner <lukas@wunner.de>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: mcp320x: Use vendor prefix
 compatible strings
Message-ID: <20180416214355.qa4y3jbqnaegmtzl@rob-hp-laptop>
References: <1523892846-25000-1-git-send-email-architekt@coding4coffee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1523892846-25000-1-git-send-email-architekt@coding4coffee.org>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Apr 16, 2018 at 05:34:06PM +0200, Fabian Mewes wrote:
> Update the example to use the compatible string including the
> vendor prefix instead of the ones deprecated in 3a872138e4b.
> 
> Signed-off-by: Fabian Mewes <architekt@coding4coffee.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/mcp320x.txt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
