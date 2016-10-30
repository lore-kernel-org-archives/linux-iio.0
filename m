Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42955 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbcJ3Qxw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 12:53:52 -0400
Subject: Re: [PATCH 2/2] Documentation: dt: iio: accel: add lng2dm sensor
 device binding
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
References: <1477429744-27713-1-git-send-email-lorenzo.bianconi@st.com>
 <1477429744-27713-3-git-send-email-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e99f9b73-094e-2f73-a077-aac7d078ab5c@kernel.org>
Date: Sun, 30 Oct 2016 16:53:50 +0000
MIME-Version: 1.0
In-Reply-To: <1477429744-27713-3-git-send-email-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/10/16 22:09, Lorenzo Bianconi wrote:
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Applied.
> ---
>  Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
> index e41fe34..c040c9a 100644
> --- a/Documentation/devicetree/bindings/iio/st-sensors.txt
> +++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
> @@ -42,6 +42,7 @@ Accelerometers:
>  - st,lsm303agr-accel
>  - st,lis2dh12-accel
>  - st,h3lis331dl-accel
> +- st,lng2dm-accel
>  
>  Gyroscopes:
>  - st,l3g4200d-gyro
> 

