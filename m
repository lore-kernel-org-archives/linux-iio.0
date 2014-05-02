Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43039 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbaEBJpN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 May 2014 05:45:13 -0400
In-Reply-To: <1399017693-29608-1-git-send-email-pmeerw@pmeerw.net>
References: <1399017693-29608-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/2] iio: Add TEMP_AMBIENT and TEMP_OBJECT channel modifiers
From: Jonathan Cameron <jic23@kernel.org>
Date: Fri, 02 May 2014 10:45:09 +0100
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Message-ID: <3233f0b6-aa1a-4395-9ce1-19968e6fc024@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On May 2, 2014 9:01:32 AM GMT+01:00, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>useful for contactless temperature sensors to distinguish
>between the ambient temperature and the temperature of the object
>
>Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
ABI docs?

Otherwise fine
>---
> drivers/iio/industrialio-core.c | 2 ++
> include/linux/iio/types.h       | 2 ++
> 2 files changed, 4 insertions(+)
>
>diff --git a/drivers/iio/industrialio-core.c
>b/drivers/iio/industrialio-core.c
>index de8b1c2..4b1f375 100644
>--- a/drivers/iio/industrialio-core.c
>+++ b/drivers/iio/industrialio-core.c
>@@ -85,6 +85,8 @@ static const char * const iio_modifier_names[] = {
> 	[IIO_MOD_LIGHT_GREEN] = "green",
> 	[IIO_MOD_LIGHT_BLUE] = "blue",
> 	[IIO_MOD_QUATERNION] = "quaternion",
>+	[IIO_MOD_TEMP_AMBIENT] = "ambient",
>+	[IIO_MOD_TEMP_OBJECT] = "object",
> };
> 
> /* relies on pairs of these shared then separate */
>diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
>index 4fdab2e..d480631 100644
>--- a/include/linux/iio/types.h
>+++ b/include/linux/iio/types.h
>@@ -54,6 +54,8 @@ enum iio_modifier {
> 	IIO_MOD_LIGHT_GREEN,
> 	IIO_MOD_LIGHT_BLUE,
> 	IIO_MOD_QUATERNION,
>+	IIO_MOD_TEMP_AMBIENT,
>+	IIO_MOD_TEMP_OBJECT,
> };
> 
> enum iio_event_type {

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
