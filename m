Return-Path: <SRS0=Zm7d=SJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8DCC10F0E
	for <linux-iio@archiver.kernel.org>; Sun,  7 Apr 2019 11:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB5A20880
	for <linux-iio@archiver.kernel.org>; Sun,  7 Apr 2019 11:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfDGLsr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:48:47 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33982 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfDGLsr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Apr 2019 07:48:47 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id CCB3C9E74F4;
        Sun,  7 Apr 2019 12:48:45 +0100 (BST)
Date:   Sun, 7 Apr 2019 12:48:43 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Valentin Manea <linux-iio@mrs.ro>
Cc:     linux-iio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] iio: accel: kxcjk1013: Add KIOX0008 ACPI Hardware-ID
Message-ID: <20190407124843.0df37687@archlinux>
In-Reply-To: <abfff08c719e6da87b6fd029d4f985e8@mrs.ro>
References: <abfff08c719e6da87b6fd029d4f985e8@mrs.ro>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 31 Mar 2019 14:54:08 +0000
Valentin Manea <linux-iio@mrs.ro> wrote:

> Add the ACPI ID for KXCJ9 sensor seen on the a Teclast X80 Power
> tablet.
> 
> Signed-off-by: Valentin Manea <linux-iio@mrs.ro>
Applied. Thanks,

Jonathan

> ---
>   drivers/iio/accel/kxcjk-1013.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c 
> b/drivers/iio/accel/kxcjk-1013.c
> index 7096e577b..aecf629ba 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1489,6 +1489,7 @@ static const struct acpi_device_id kx_acpi_match[] 
> = {
>   	{"KXCJ1013", KXCJK1013},
>   	{"KXCJ1008", KXCJ91008},
>   	{"KXCJ9000", KXCJ91008},
> +	{"KIOX0008", KXCJ91008},
>   	{"KIOX0009", KXTJ21009},
>   	{"KIOX000A", KXCJ91008},
>   	{"KIOX010A", KXCJ91008}, /* KXCJ91008 inside the display of a 2-in-1 
> */

