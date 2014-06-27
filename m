Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:57933 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbaF0O2e (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jun 2014 10:28:34 -0400
Message-ID: <53AD7F8F.7070501@roeck-us.net>
Date: Fri, 27 Jun 2014 07:28:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Johannes Pointner <johannes.pointner@gmail.com>,
	Jean Delvare <jdelvare@suse.de>
CC: Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] hwmon: ntc_thermistor: Adds support for EPCOS ntc
 thermistor
References: <CAJKbBDDFD294xnqkYq_auW=ppMyPJxigYUF-YAhXZVXw3NN5Xg@mail.gmail.com>
In-Reply-To: <CAJKbBDDFD294xnqkYq_auW=ppMyPJxigYUF-YAhXZVXw3NN5Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/27/2014 05:59 AM, Johannes Pointner wrote:
> The patch series adds support for the ntc thermistor B57330V2103 from
>   EPCOS.
>
> Signed-off-by: Johannes Pointner <johannes.pointner@gmail.com>

Hi Johannes,

you sent two patches in the same e-mail, and it is all corrupted.
All tabs have been replaced with spaces.

Guenter

> ---
>   Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 46a311e..97c9c06 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -42,6 +42,7 @@ dmo    Data Modul AG
>   ebv    EBV Elektronik
>   edt    Emerging Display Technologies
>   emmicro    EM Microelectronic
> +epcos    EPCOS AG
>   epfl    Ecole Polytechnique Fédérale de Lausanne
>   epson    Seiko Epson Corp.
>   est    ESTeem Wireless Modems
>

