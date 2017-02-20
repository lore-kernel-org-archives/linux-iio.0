Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:46294 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbdBTIfL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 03:35:11 -0500
Subject: Re: [PATCH] iio: adc: xilinx: Fix error handling
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        michal.simek@xilinx.com, soren.brinkmann@xilinx.com
References: <20170219202928.20296-1-christophe.jaillet@wanadoo.fr>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <880c338e-7e81-83c7-613a-d8030c14bac0@metafoo.de>
Date: Mon, 20 Feb 2017 09:35:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170219202928.20296-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/19/2017 09:29 PM, Christophe JAILLET wrote:
> Reorder error handling labels in order to match the way resources have
> been allocated.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks, looks good.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

I think there is one more issue

    ret = xadc->ops->setup(pdev, indio_dev, irq);
    if (ret)
        goto err_free_samplerate_trigger;

should be

	goto err_clk_disable_unprepare;

