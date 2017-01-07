Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42980 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942080AbdAHJsv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:48:51 -0500
Subject: Re: [PATCH v7 01/12] devres: trivial whitespace fix
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1483532187-28494-1-git-send-email-peda@axentia.se>
 <1483532187-28494-2-git-send-email-peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <23cc9f7c-f830-d295-d06f-ed08ad2425af@kernel.org>
Date: Sat, 7 Jan 2017 22:29:31 +0000
MIME-Version: 1.0
In-Reply-To: <1483532187-28494-2-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/01/17 12:16, Peter Rosin wrote:
> Signed-off-by: Peter Rosin <peda@axentia.se>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  Documentation/driver-model/devres.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index ca9d1eb46bc0..dc51fb024190 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -330,7 +330,7 @@ MEM
>    devm_kzalloc()
>  
>  MFD
> - devm_mfd_add_devices()
> +  devm_mfd_add_devices()
>  
>  PER-CPU MEM
>    devm_alloc_percpu()
> 

