Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D7DCD8CA2
	for <linux-iio@archiver.kernel.org>; Tue, 10 Oct 2023 15:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjJJP4Q (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 10 Oct 2023 11:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjJJP4P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Oct 2023 11:56:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F34593;
        Tue, 10 Oct 2023 08:56:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42923C433C7;
        Tue, 10 Oct 2023 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696953373;
        bh=J6DZXxIQ6jsiYqSBJX4dAgm68zxwd4lkQ+Dj0naMcjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mwUM34TOidAihbNI/GdF2Zpx+h2Ls/ifYLlQWyIHfRmJsAARzfBjmVzU0bFb0NR+t
         lZFa7pQjgd2Jcpyr3AXrvNQc9jlka5IBqvvz9MAm1vk61UEydQH0DFaFpAcm2zB9Wv
         r25WgoteqULtlw94eqJN+0UddrbMHxIETUDqDY7dABr2Dc8bk9ATTJvikuNUghKbhX
         BsuOS2bgKK86ZDVU15L5tmhuRds1dh3HCXCJuVxPoLAPXGJNWg28l27OIA/ZX/L36d
         JhLwgFDjAz/7wReT0mRaeEy+Pyz2TSD7OkyxNfq/uiaOBc5+QrgUyDLv2/fprEgkEy
         NU6p4BzHpHqgw==
Date:   Tue, 10 Oct 2023 16:56:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/17] staging: iio: resolver: ad2s1210: convert DOS
 mismatch threshold to event attr
Message-ID: <20231010165624.3c1b1341@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-10-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-10-ec00746840fc@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  5 Oct 2023 19:50:27 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The AD2S1210 has a programmable threshold for the degradation of signal
> (DOS) mismatch fault. This fault is triggered when the difference in
> voltage between the sine and cosine inputs exceeds the threshold. In
> other words, when the magnitude of sine and cosine inputs are equal,
> the AC component of the monitor signal is zero and when the magnitudes
> of the sine and cosine inputs are not equal, the AC component of the
> monitor signal is the difference between the sine and cosine inputs.
> So the fault occurs when the magnitude of the AC component of the
> monitor signal exceeds the DOS mismatch threshold voltage.
> 
> This patch converts the custom device DOS mismatch threshold attribute
> to an event magnitude attribute on the monitor signal channel.
> 
> The attribute now uses millivolts instead of the raw register value in
> accordance with the IIO ABI.
> 
> Emitting the event will be implemented in a later patch.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Applied,

Thanks,

Jonathan
