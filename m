Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BDACD8CA2
	for <linux-iio@archiver.kernel.org>; Tue, 10 Oct 2023 15:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjJJPrG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 10 Oct 2023 11:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjJJPrF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Oct 2023 11:47:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0413097;
        Tue, 10 Oct 2023 08:47:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630DFC433C8;
        Tue, 10 Oct 2023 15:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696952823;
        bh=Gs9ENmC70BtlEVTiCiEVzfq0QWempepVkVcAfg4SrxY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cYAruBgbXU1xRhMhpdCa8E4SWCrBb4XQtJYPK7cfDLcd1ASjOMqz69kN96MclwD+4
         U7hOdayZxTn0I6wvvASCUV194XYz2Nq0A8RA8zYPH0YXVHzOGEIgSZuf23etN8Ei1t
         k+S2pC4d+SkOH9HOG4cYa1Lfsexe3naZlCHN5gj+Ck5hT3MUS1b761iNj/+hb34YIu
         yXoJssRxIvtuI+CsGsj68A0aYD/drSUygU+hB7h4T18whk5Rnu37sZGTvmlLeEmIe7
         zSbhwGvpDAPxom/ZqknULoHBQgIQ9bjnMdikm/CtLqMx6Glo/E11rYWCSpkxI3/qWw
         apBdeHepc5AAA==
Date:   Tue, 10 Oct 2023 16:47:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/17] staging: iio: resolver: ad2s1210: add
 triggered buffer support
Message-ID: <20231010164714.2b949a16@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-6-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-6-ec00746840fc@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  5 Oct 2023 19:50:23 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds support for triggered buffers to the AD2S1210 resolver driver.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

