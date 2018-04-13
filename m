Return-Path: <SRS0=dex8=HC=gmail.com=robherring2@kernel.org>
Date: Fri, 13 Apr 2018 13:33:07 -0500
From: Rob Herring <robh@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: jic23@kernel.org, ludovic.desroches@microchip.com,
	alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v3 04/11] dt-bindings: input: touchscreen: add pressure
 threshold touchscreen property
Message-ID: <20180413183307.vqadfoxvwyzyrjti@rob-hp-laptop>
References: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
 <1523350677-27106-5-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1523350677-27106-5-git-send-email-eugen.hristev@microchip.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Apr 10, 2018 at 11:57:50AM +0300, Eugen Hristev wrote:
> Add a common touchscreen optional property that will specify
> the minimum pressure applied to the screen that is needed
> such that the driver will report the touch event.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
