Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34292 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbbIEIKg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 04:10:36 -0400
MIME-Version: 1.0
In-Reply-To: <1441432406-4761-4-git-send-email-mranostay@gmail.com>
References: <1441432406-4761-1-git-send-email-mranostay@gmail.com>
	<1441432406-4761-4-git-send-email-mranostay@gmail.com>
Date: Sat, 5 Sep 2015 11:10:33 +0300
Message-ID: <CAEnQRZBTMeEDP_iWHtpJX1BwuCmrEcSmB-8whsVGiL8VhfOTsw@mail.gmail.com>
Subject: Re: [RFC v1 3/4] devicetree: add SGX Sensortech vendor id
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Matt Ranostay <mranostay@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

don't forget to cc devicetree people.

On Sat, Sep 5, 2015 at 8:53 AM, Matt Ranostay <mranostay@gmail.com> wrote:
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ac5f0c3..281e8f0 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -191,6 +191,7 @@ sbs Smart Battery System
>  schindler      Schindler
>  seagate        Seagate Technology PLC
>  semtech        Semtech Corporation
> +sgx    SGX Sensortech
>  sharp  Sharp Corporation
>  sil    Silicon Image
>  silabs Silicon Laboratories
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
