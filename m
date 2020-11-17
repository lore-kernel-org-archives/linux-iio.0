Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F44C64E8A
	for <linux-iio@archiver.kernel.org>; Tue, 17 Nov 2020 09:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EED72168B
	for <linux-iio@archiver.kernel.org>; Tue, 17 Nov 2020 09:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1Y1XNl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgKQJxD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 17 Nov 2020 04:53:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbgKQJxC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Nov 2020 04:53:02 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFC90222EC;
        Tue, 17 Nov 2020 09:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605606782;
        bh=SnHQbdkvxuAChZ5ixmzF3fbvm175aeVVKJTXOCMP2HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1Y1XNl7/SRD+x3PG4PsjybonydRuIwqi2SFAnOrivH/3tp4SOw+8JMFjYWJrnUQs
         NhgXiV704/TwLmvWus3TM2W3vs4/jiJjuQNsw35afBsdjbVDB+RfSIMWnVP1mbAYpA
         4C29x9ce8g5sra7moWM0bIy0/RD5dFInjR4qeLAQ=
Date:   Tue, 17 Nov 2020 10:53:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO and counter fixes for the 5.10 cycle.
Message-ID: <X7OdoOZJgYup1K0N@kroah.com>
References: <20201116185719.17696afa@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116185719.17696afa@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 16, 2020 at 06:57:19PM +0000, Jonathan Cameron wrote:
> The following changes since commit 7e97e4cbf30026b49b0145c3bfe06087958382c5:
> 
>   staging: fieldbus: anybuss: jump to correct label in an error path (2020-10-27 13:24:51 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.10a

Pulled and pushed out,t hanks.

greg k-h
