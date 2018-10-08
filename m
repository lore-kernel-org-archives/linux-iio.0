Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:37394 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbeJIDYU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Oct 2018 23:24:20 -0400
Date: Mon, 8 Oct 2018 21:10:47 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: David Frey <dpfrey@gmail.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: CONFIG_IIO_TRIGGERED_BUFFER lacks Kconfig description
Message-ID: <20181008211047.30c7986c@archlinux>
In-Reply-To: <d784af9b-c687-530d-4499-fed635a7409e@gmail.com>
References: <d784af9b-c687-530d-4499-fed635a7409e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 3 Oct 2018 08:47:00 -0700
David Frey <dpfrey@gmail.com> wrote:

> Hi,
> 
> I have noticed that CONFIG_IIO_TRIGGERED_BUFFER doesn't have any
> description in Kconfig.  I'm not an expert on Kconfig, but I believe
> this means that it is not possible to set the config option explicitly
> using menuconfig.  I see this as a problem because it means that you
> can't really build the necessary kernel config to support an out of tree
> driver which depends on CONFIG_IIO_TRIGGERED_BUFFER.  If I'm wrong about
> this, please let me know why.

The basic answer is that it's a trade off between presenting more complex
options in menuconfig for in kernel drivers and supporting easy out of
tree builds.  Is it particularly important for your usecase to have your
driver built out of tree and is not possible to patch the kernel to allow
it if you need to?

So basically provide a strong argument for why and lets see what others
think about this.

Jonathan

> 
> Thanks,
> David
