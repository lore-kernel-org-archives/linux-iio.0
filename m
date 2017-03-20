Return-Path: <SRS0=/yVt=25=gmail.com=robherring2@kernel.org>
Date: Mon, 20 Mar 2017 14:34:04 -0500
From: Rob Herring <robh@kernel.org>
To: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, dmitry.torokhov@gmail.com,
	michael.hennerich@analog.com, daniel.baluta@gmail.com,
	amsfield22@gmail.com, florian.vaussard@heig-vd.ch,
	linux-kernel@vger.kernel.org, mark.rutland@arm.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: accel: adxl345: Add optional
 interrupt-names support
Message-ID: <20170320193404.6c7s4c5qpdgvim2p@rob-hp-laptop>
References: <1489403497-27849-1-git-send-email-eraretuya@gmail.com>
 <1489403497-27849-2-git-send-email-eraretuya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489403497-27849-2-git-send-email-eraretuya@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 13, 2017 at 07:11:34PM +0800, Eva Rachel Retuya wrote:
> Add interrupt-names property in order to specify interrupt pin in use.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/adxl345.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
