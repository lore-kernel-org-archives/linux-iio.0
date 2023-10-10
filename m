Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DB9CD8CA7
	for <linux-iio@archiver.kernel.org>; Tue, 10 Oct 2023 16:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjJJQId (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 10 Oct 2023 12:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjJJQI2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Oct 2023 12:08:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8092F97;
        Tue, 10 Oct 2023 09:08:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE7BC433C7;
        Tue, 10 Oct 2023 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696954106;
        bh=hvsSbVRMxYaENVzyHutIe4XZE6lBZw3zkFmbhOVi42E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eH2nOTO4QKmo8B+WTWRfKTne9WyvPi9WHgqV1VvNn14OCAJdHyaHfPlb9Yb/lQ+Ix
         KIAVIMWhD8GEvjVRkyuhJQEzdjOCW8694l9tWgai25oY44+Uw59Ouv+t6QfZzk90Dp
         bCZ2wszQ4pCLIfpYvmT7lrcdlyaNe6oExMiVp+H4+LQskLzEnMV5HiAm9jgu0V9CB7
         zd1u9M3VImrd8NnezyOqFaYSbBINRXHy7TKy8fdqQ4n+md95gJx0ihuTHmixRNGveE
         oImKvRlvmpOgenwXCJbmNecr8otwz4fm+gMdGDvs9QVMTWj+YuPM+tJBNWur6QylXz
         cwvlU3q9ryzuQ==
Date:   Tue, 10 Oct 2023 17:08:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 15/17] staging: iio: resolver: ad2s1210: add label
 attribute support
Message-ID: <20231010170836.285effbb@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-15-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-15-ec00746840fc@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  5 Oct 2023 19:50:32 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The ad2s1210 resolver driver has quite a few channels, mostly for
> internal signals for event support. This makes it difficult to know
> which channel is which. This patch adds a label attribute to the
> channels to make it easier to identify them.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.
