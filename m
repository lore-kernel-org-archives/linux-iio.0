Return-Path: <SRS0=dex8=HC=gmail.com=robherring2@kernel.org>
Date: Fri, 13 Apr 2018 08:43:40 -0500
From: Rob Herring <robh@kernel.org>
To: Martin Kelly <mkelly@xevo.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: Re: [PATCH v5 2/2] dt-bindings: iio:imu:mpu6050: support more
 interrupt types
Message-ID: <20180413134340.x5xhdlyeibx3kfch@rob-hp-laptop>
References: <20180409202128.5031-1-mkelly@xevo.com>
 <20180409202128.5031-2-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409202128.5031-2-mkelly@xevo.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Apr 09, 2018 at 01:21:28PM -0700, Martin Kelly wrote:
> Document that the inv_mpu6050 driver now supports falling edge, rising
> edge, level low, and level high interrupt types, rather than just rising
> edge.
> 
> The language used is the same as that in st_lsm6dsx.txt.
> 
> Signed-off-by: Martin Kelly <mkelly@xevo.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
