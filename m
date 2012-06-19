Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62773 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab2FSAdD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 20:33:03 -0400
Received: by pbbrp8 with SMTP id rp8so8899664pbb.19
        for <linux-iio@vger.kernel.org>; Mon, 18 Jun 2012 17:33:02 -0700 (PDT)
Date: Mon, 18 Jun 2012 17:32:59 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v4] iio: add vcnl4000 combined ALS and proximity sensor
Message-ID: <20120619003259.GA587@kroah.com>
References: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jun 18, 2012 at 08:33:00PM +0200, Peter Meerwald wrote:
> minimal driver, no IR current control and proximity/event handling
> yet

Care to fix up the basic checkpatch.pl warnings and errors it produces?

(I shouldn't have to ask this...)

greg k-h
