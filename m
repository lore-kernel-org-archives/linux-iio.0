Return-Path: <SRS0=e72L=KJ=gmail.com=robherring2@kernel.org>
Date: Wed, 25 Jul 2018 10:01:40 -0600
From: Rob Herring <robh@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: jic23@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
	david.brown@linaro.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
	fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com,
	drew.paterson@ams.com
Subject: Re: [PATCH v2 4/7] dt-bindings: trivial: remove tsl2772
Message-ID: <20180725160140.GA19051@rob-hp-laptop>
References: <20180717084158.23532-1-masneyb@onstation.org>
 <20180717084158.23532-5-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180717084158.23532-5-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 17, 2018 at 04:41:55AM -0400, Brian Masney wrote:
> Remove the tsl2772 driver from trivial-devices.txt. A separate
> patch added the binding information to the file
> Documentation/devicetree/bindings/iio/light/tsl2772.txt.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  Documentation/devicetree/bindings/trivial-devices.txt | 10 ----------
>  1 file changed, 10 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
