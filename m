Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-229.synserver.de ([212.40.185.229]:1088 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753962AbbKLKVD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2015 05:21:03 -0500
Message-ID: <56446807.8080509@metafoo.de>
Date: Thu, 12 Nov 2015 11:20:55 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Marc Titinger <mtitinger@baylibre.com>, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mturquette@baylibre.com, bcousson@baylibre.com,
	ptitiano@baylibre.com
Subject: Re: [RFC 4/4] iio: ina2xx: add SOFTWARE buffer mode using an iio
 kfifo.
References: <1447171653-12756-1-git-send-email-mtitinger@baylibre.com> <1447171653-12756-5-git-send-email-mtitinger@baylibre.com> <56423613.6090403@metafoo.de> <5644675A.2080308@baylibre.com>
In-Reply-To: <5644675A.2080308@baylibre.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/12/2015 11:18 AM, Marc Titinger wrote:
[...]
>> Slightly OT, but do you already have some Sigrok IIO support? I have this
>> scheduled for end of the month, maybe we can align our strategies here and
>> avoid duplicated work.
> 
> How fortunate! I've started some preliminary work like cloning the demo
> driver into a skeletton for 'hardware/generic-iio/api.c', adding the
> build/ac plumbing, and linking to libiio with the idea of using iio_info to
> create a generic enumeration of the iio-context into sigrok channels.
> 
> Now, I'm not familiar with Glib and it might not be my prio until a couple
> of weeks, so I'd be super happy to wait for you if you are keen to do that
> part :)
> 
> What would be the best spot to chat about this ?

#sigrok on irc.freenode.net

