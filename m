Return-Path: <SRS0=36nr=PP=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822CCC43387
	for <linux-iio@archiver.kernel.org>; Mon,  7 Jan 2019 13:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503F62147C
	for <linux-iio@archiver.kernel.org>; Mon,  7 Jan 2019 13:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="Ih+Zo1xE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfAGNzY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:55:24 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:34687 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfAGNzY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jan 2019 08:55:24 -0500
Received: by mail-yb1-f170.google.com with SMTP id w6so173007ybq.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Jan 2019 05:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iG8L90of4HLk388B5/RMaJ8vPgwPpDUunKhdJNk5GPo=;
        b=Ih+Zo1xETLShU6jem2GGucgJu9ASavH8I5VMhEnJ2YYCFWQXZyoDXAsAinj0EipJjj
         rahlKE6YUdHJlNRFOGQiuvP8GSjcAJti+FXtg4h8an0iROjrI3EpwGFax+kHWxgj1Mt6
         pc5CkuCE60TFt/ORQnCBX/AoTjcn4hgqC406zgPKmTryUt4PfnnAGBefc2xTn9+loUx5
         KMkScAEfPlv0oF5jVEnLkqdvgrJqTWlkQ3AmunoeAq2C7jktakJe+mduarh5nDwIMAPa
         2oJHM25L+TGdBpUE/RhElFSUNFtWaplz/kIKRTmnQV9ebksZYnq8SiS7hsMkhPACl7Fz
         kpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iG8L90of4HLk388B5/RMaJ8vPgwPpDUunKhdJNk5GPo=;
        b=I31SaOr2RSQSz1PSZ7IL8gWa7y2/gBtMwiH06WKECIM3K3pGaMWnwOw9MCd1ovW5oo
         iNzo+Qjz63FIropytfJVp9XWDEtsaAZkgZALEykVEfmEj2uaK5TUVKbvaaAX2lwiPlZj
         u/kFLFxX5n3CfnDAgv9QrH7BG2Rcaie9wASBlgSmovKYdd2Ix+Yito5Za2Ut5a11/mnr
         Pf00gHbkbXg5o3mluBlZU+KDNphOP/LSsuwteWOBFAIlrSrPbbP6Dly3ixaPHAIsUvV6
         CTq8xUdl8ulnI1NiKmo2YkXDJvqVM7GhqnK4rQ/mIVkol2wH56Ug5iDAZpIgoomfs24n
         N/CA==
X-Gm-Message-State: AJcUukeXT1MNlHmyLPUSjrsA8+SQczgnhVwAliepcd5imM0l3mPVC3dv
        33qZB1fOqlvshFozZAQilbAT9nh3Aeos9Fz1A2fpGMWNE6M=
X-Google-Smtp-Source: ALg8bN7b8Gp8qu3inWoANaTWWkElOx528PXYtvIolxdsy/hSrBHAy1mAYqS12jUWsICBIrwvED+MpCXUfiblH2MsyR8=
X-Received: by 2002:a25:2844:: with SMTP id o65mr712041ybo.318.1546869323557;
 Mon, 07 Jan 2019 05:55:23 -0800 (PST)
MIME-Version: 1.0
References: <CAKKE0ZHmODzhvjPNJFVgT2cF_F=f2kNKr5K_CGP+0XgA5XZokw@mail.gmail.com>
In-Reply-To: <CAKKE0ZHmODzhvjPNJFVgT2cF_F=f2kNKr5K_CGP+0XgA5XZokw@mail.gmail.com>
From:   Patrick Havelange <patrick.havelange@essensium.com>
Date:   Mon, 7 Jan 2019 14:55:11 +0100
Message-ID: <CAKKE0ZEB=Tpe2sgjs0uv7DXw9kjheHwTGGaw6oOLK_y_yAMoJw@mail.gmail.com>
Subject: Re: New IIO/counter driver
To:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I'm in the process of adding a new IIO/counter driver, however I also
saw that there was a work in progress to have a separate counter
subsystem ( https://marc.info/?l=linux-iio&m=153974167727206 ). But it
seems there is no recent progress on it.
What is the state of those patches ? Is it still interesting to
develop the driver as an IIO/counter , or should I use already that
new subsystem ?

Best Regards,

Patrick Havelange.
