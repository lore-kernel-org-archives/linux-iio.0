Return-Path: <SRS0=AS3l=2M=gmail.com=robherring2@kernel.org>
Date: Fri, 3 Mar 2017 01:05:41 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannanece23@gmail.com>
Cc: jic23@kernel.org, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] iio:light: Add support for STMicro VL6180 sensor
Message-ID: <20170303070541.aevjulduzucui3wm@rob-hp-laptop>
References: <20170302184031.GA27741@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170302184031.GA27741@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Mar 03, 2017 at 12:10:31AM +0530, Manivannan Sadhasivam wrote:
> This patch adds support for STMicro VL6180 - ALS and proximity sensor. Sensor is capable of measuring the light
> intensity as well as object distance using TOF(Time of Flight) technology.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannanece23@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/vl6180.txt       |  16 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/light/Kconfig                          |  10 +
>  drivers/iio/light/Makefile                         |   1 +
>  drivers/iio/light/vl6180.c                         | 544 +++++++++++++++++++++
>  4 files changed, 571 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vl6180.txt
>  create mode 100644 drivers/iio/light/vl6180.c
