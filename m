Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA0DC001DE
	for <linux-iio@archiver.kernel.org>; Sun, 23 Jul 2023 12:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjGWMgn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 23 Jul 2023 08:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGWMgm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2023 08:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D78A183;
        Sun, 23 Jul 2023 05:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C553A60CA3;
        Sun, 23 Jul 2023 12:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506F8C433C7;
        Sun, 23 Jul 2023 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690115799;
        bh=+EAgR4D+yCzWZ7kXBmjX86Sny7tqc0D+StIe+p2etLw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PvDq8pcLm7HbMfRGQyjHnFIAOy4O8mglNf9elynmUtTWbTNbXKLwPDoXghkfB7XWw
         JBz5WU24kGiQ6al9Y54TaIVcLdpHZurNKI/7DIHh8g/Sz0a8IItmlzqTqIQuaz7ogI
         NPupz/skJQ4CJm6fiHaaPxuwLt59Aj+oGi+nXv4h0ixmtsIZ5NolMIsQhV1NSVNuj/
         6pq8UWRrbvnn9GHpjRm2zO5XGsRgtq5425UHHYNYbgKkVHwRXat8KzHLfRWv7h1/F3
         2EsSxB/heKM44kcbCp25sO09he6Dm1S2mKdJNnfc+z70sLnYQowzMu7yQtpBZEihqG
         mgEg9CZoB5RGQ==
Date:   Sun, 23 Jul 2023 13:36:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: imu: adis16475.c: Add delta angle and delta
 velocity channels
Message-ID: <20230723133636.4b8fc5f1@jic23-huawei>
In-Reply-To: <20230719123152.309624-4-ramona.bolboaca@analog.com>
References: <20230719123152.309624-1-ramona.bolboaca@analog.com>
        <20230719123152.309624-4-ramona.bolboaca@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Jul 2023 15:31:52 +0300
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> Add support for delta angle and delta velocity raw and buffer
> readings to adis16475 driver.
> 
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
As noted in my reply to Nuno's review, the question of channel type
is still unresolved.

https://lore.kernel.org/all/20230720193457.272f02a9@jic23-huawei/

Thanks,

Jonathan
