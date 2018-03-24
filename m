Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:41024 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeCXO3l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Mar 2018 10:29:41 -0400
Date: Sat, 24 Mar 2018 14:29:38 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Mahmoud Nagy <mnagy1312@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: Can't enable IIO_DUMMY_EVGEN for compiling
Message-ID: <20180324142938.0d358864@archlinux>
In-Reply-To: <b69d3da4-7c7b-5f00-6a77-81d11f6b52f9@gmail.com>
References: <b69d3da4-7c7b-5f00-6a77-81d11f6b52f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 24 Mar 2018 14:26:23 +0200
Mahmoud Nagy <mnagy1312@gmail.com> wrote:

> So I'm starting with IIO_tasks,
> and I have a little problem,
> It seems I can't enable IIO_DUMMY_EVGEN config, nconfig gives "XXX" next
> to it, I enabled every other config that is needed for task1, maybe for
> a certain dependency that I can't see or something.
> need help please.
It's not a config variable that should be visible in the gui interfaces
and when I run nconfig it isn't.

That symbol should be selected (automatically enabled) by
CONFIG_IIO_SIMPLE_DUMMY_EVENTS

Jonathan

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

