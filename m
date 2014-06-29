Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55269 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbaF2Tpv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jun 2014 15:45:51 -0400
Message-ID: <53B06CEC.9060009@roeck-us.net>
Date: Sun, 29 Jun 2014 12:45:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Johannes Pointner <johannes.pointner@gmail.com>
CC: Jean Delvare <jdelvare@suse.de>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] Adds the vendor prefix "epcos" to vendor-prefixes.txt
References: <CAJKbBDDFD294xnqkYq_auW=ppMyPJxigYUF-YAhXZVXw3NN5Xg@mail.gmail.com> <53AD7F8F.7070501@roeck-us.net> <2420621.lSeA9X6AqK@lenovobook>
In-Reply-To: <2420621.lSeA9X6AqK@lenovobook>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/27/2014 10:53 AM, Johannes Pointner wrote:
> This patch adds the vendor prefix for "epcos" to the vendor-prefixes.
>
> Signed-off-by: Johannes Pointner <johannes.pointner@gmail.com>

Copying devicetree mailing list for Ack.

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
> @@ -42,6 +42,7 @@ dmo	Data Modul AG
>   ebv	EBV Elektronik
>   edt	Emerging Display Technologies
>   emmicro	EM Microelectronic
> +epcos	EPCOS AG
>   epfl	Ecole Polytechnique Fédérale de Lausanne
>   epson	Seiko Epson Corp.
>   est	ESTeem Wireless Modems
>

