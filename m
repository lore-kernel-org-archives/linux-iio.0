Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F025C43334
	for <linux-iio@archiver.kernel.org>; Sun, 26 Jun 2022 22:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiFZWoT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 26 Jun 2022 18:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiFZWoT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 18:44:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930262BCA
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 15:44:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52A09B80E31
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 22:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55A1C34114;
        Sun, 26 Jun 2022 22:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656283456;
        bh=j86j+AQlLgddVLS2gLm6awly959mdwHGP0YxwAe3q58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AiE1J9+TVFl202MvLKvYOrkKYEskEdt8YC5reQOH+i4vYHaBdLar3v1Cz2ntecVqH
         +A9kEC5DlKA7jlxg8EsBOOV1pB1EPeHVZjxryiX2tcfLxWJg+G/Wqfm2eDuppcHuG9
         oEUu/NEG8Jp2/++wrDSJC5qJI2baNdO8hG4zxfWzIMbPAcrNMCGYOx3QU590pMh5Ed
         ziIfdipXMx6SzcQI1XO2uyzF3O0nnvbfrPG1Q3Bzl4NFJbTjLanEL1CuOT5LStu0Dk
         UWRtZqGuPJIk3BpoDgnou3qsJNvIET5/zccLGabOKc9KZOgi3wkYOSXa77vBLsOvR4
         6kssF+6lPD/pg==
Date:   Sun, 26 Jun 2022 23:44:11 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH 4/4] iio: ABI: sx9324: Squash some formatting to keep
 scripting happy.
Message-ID: <20220626234411.227c1a87@sal.lan>
In-Reply-To: <20220626165511.602202-5-jic23@kernel.org>
References: <20220626165511.602202-1-jic23@kernel.org>
        <20220626165511.602202-5-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun, 26 Jun 2022 17:55:11 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The indenting added in here to give bullet points is nice to read
> but unfortunately our docs building scripts trip up on it.
> 
> make htmldocs gives
> ../iio/Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: ERROR: Unexpected indentation.
> 
> So drop the pretty indenting to avoid that error message.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-sx9324 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sx9324 b/Documentation/ABI/testing/sysfs-bus-iio-sx9324
> index 632e3321f5a3..9c1e8884a738 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-sx9324
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-sx9324
> @@ -8,7 +8,7 @@ Description:
>  		+ not connected (HZ),
>  		+ grounded (GD),
>  		+ connected to an antenna where it can act as a base
> -		  (DS - data shield), or measured input (MI).
> +		(DS - data shield), or measured input (MI).


Actually, the fix would be to simply add a blank line before the list,
e. g.:

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-sx9324 b/Documentation/ABI/testing/sysfs-bus-iio-sx9324
index 632e3321f5a3..a8342770e7cb 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-sx9324
+++ b/Documentation/ABI/testing/sysfs-bus-iio-sx9324
@@ -5,6 +5,7 @@ Contact:	Gwendal Grignou <gwendal@chromium.org>
 Description:
 		SX9324 has 3 inputs, CS0, CS1 and CS2. Hardware layout
 		defines if the input is
+
 		+ not connected (HZ),
 		+ grounded (GD),
 		+ connected to an antenna where it can act as a base


Regards,
Mauro
