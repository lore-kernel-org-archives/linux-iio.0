Return-Path: <SRS0=HNOD=OR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E86C04EB8
	for <linux-iio@archiver.kernel.org>; Sat,  8 Dec 2018 21:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72FC20868
	for <linux-iio@archiver.kernel.org>; Sat,  8 Dec 2018 21:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544303446;
	bh=U01y1HyI/li6mVo0iEZWkUqLHxkPCPI/UkWSjlzCqB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JmjVn3HMsr9H0T3trFziuQqMgy/xrTFk1mzAEYBBiiZF2SGMKlrfMKkFYuQVZvZXE
	 y8OsSpxHu0Lb2q4TZB27cB08bAXcCbr2xGN9+IWyFqCw+z4cZwwKOTioQc8MgSHU79
	 VMP6mHmj1xX6wTtqvwy+RXgsKIo6s8wyCVnbUjuE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72FC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbeLHVKq (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 8 Dec 2018 16:10:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeLHVKp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Dec 2018 16:10:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBB1F2082D;
        Sat,  8 Dec 2018 21:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544303445;
        bh=U01y1HyI/li6mVo0iEZWkUqLHxkPCPI/UkWSjlzCqB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nC7gwRcPWVmLskllOOIuv7UsKqI7i/DM3wCrBqkqS3KiJkihm6jsvjTF3WZ6WyhZw
         Pj/vTcLKnNsDOc8cJwxrc+f7Z68tElHuYYODjyJ7ntpzLm2rLd+YqnDpAYuEG5ZCOY
         +d71vLrsLO+KpB+ZDN0YJlKxcmL6EYbD/z0Lnxdg=
Date:   Sat, 8 Dec 2018 22:10:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, stefan.popa@analog.com,
        alexandru.Ardelean@analog.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH 0/3] Add devicetree support for ad5933
Message-ID: <20181208211043.GA25188@kroah.com>
References: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
 <CAAX=9sVrbu2U9go_d1G5=rGRa9AYT+betx9gyKWNXXU4adg4Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAX=9sVrbu2U9go_d1G5=rGRa9AYT+betx9gyKWNXXU4adg4Bg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 08, 2018 at 04:56:45PM -0200, Marcelo Schmitt wrote:
> Parts of this work came from contributions of Alexandru Ardelean and
> Dragos Bogdan, I and Gabriel would like to thank for the insights
> provided by their previous patches. Maybe it would be the case to add
> them as co-authors of this patch set.

That's what the Co-developed-by: tag is for, please use it :)

