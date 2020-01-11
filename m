Return-Path: <SRS0=BLhQ=3A=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE52C33C9E
	for <linux-iio@archiver.kernel.org>; Sat, 11 Jan 2020 11:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EADD20842
	for <linux-iio@archiver.kernel.org>; Sat, 11 Jan 2020 11:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578743735;
	bh=zf3aky38BFQys5osBniOy3aL6y5X0B2KB1mSCjcd3po=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=B7/H+OzKUyw06JY3/LwAWdy+Dxx5TIELaJ37+4cWwL732Fn1PSz/ZTN2RwpKct99k
	 hP7hDSolyxvRQKZ+IfT8Nost4sXfjCttaLCl3pDtbO3voCYDvtZFm9bqqiMs9arVgS
	 7VR4/zuELG0dlD1UAhzj8/kgvcLc8HrURDM1Ei0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgAKLze (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 11 Jan 2020 06:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgAKLze (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 06:55:34 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1EF2082E;
        Sat, 11 Jan 2020 11:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578743734;
        bh=zf3aky38BFQys5osBniOy3aL6y5X0B2KB1mSCjcd3po=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T237RgWUut0WIWOsIofuwixaPYKnET5gGNwYEjZCoAS4LtrYB6jnS9quMWXbuH4I2
         eXJxEMF/Gr7jOk9mRenA8Qut7Ac6CHWVfXgxvbrkkeV+diZVa+NaAOBNQUodtaLEi2
         wyWh2nmozVMsQq3AujloMjGj6dwrtLwrY3L7ApxA=
Date:   Sat, 11 Jan 2020 11:55:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kent Gustavsson <kent@minoris.se>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: dht11 remove TODO since it doesn't make
 sense
Message-ID: <20200111115529.68d0cf88@archlinux>
In-Reply-To: <20200104181929.1505510-1-kent@minoris.se>
References: <20200104181929.1505510-1-kent@minoris.se>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  4 Jan 2020 19:19:29 +0100
Kent Gustavsson <kent@minoris.se> wrote:

> DHT11 isn't addressable and will trigger temperature measurement on any
> data sent on the bus.
> 
> Signed-off-by: Kent Gustavsson <kent@minoris.se>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/dht11.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> index b459600e1a33..d05c6fdb758b 100644
> --- a/drivers/iio/humidity/dht11.c
> +++ b/drivers/iio/humidity/dht11.c
> @@ -174,7 +174,6 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
>  	struct iio_dev *iio = data;
>  	struct dht11 *dht11 = iio_priv(iio);
>  
> -	/* TODO: Consider making the handler safe for IRQ sharing */
>  	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
>  		dht11->edges[dht11->num_edges].ts = ktime_get_boottime_ns();
>  		dht11->edges[dht11->num_edges++].value =

