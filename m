Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:51689 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbcDRMRk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 08:17:40 -0400
Subject: Re: Question about differential muxing
To: "Andrew F. Davis" <afd@ti.com>, Jonathan Cameron <jic23@kernel.org>
References: <5711362A.1020700@ti.com> <57123BA0.4070501@kernel.org>
 <5713D9A7.4060106@ti.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5714D060.2000209@metafoo.de>
Date: Mon, 18 Apr 2016 14:17:36 +0200
MIME-Version: 1.0
In-Reply-To: <5713D9A7.4060106@ti.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/17/2016 08:44 PM, Andrew F. Davis wrote:
[...]
> 
> What about for buffered reads, active_scan_mask seems to be sent as bits
> in a 64bit variable, does this then lead to a hard limitation of 64
> channels?

It's a bitmask constructed from an array of 64-bit words. It's only limited
by the memory your system has.

