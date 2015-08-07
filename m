Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f196.google.com ([209.85.213.196]:35562 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbbHGDzt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Aug 2015 23:55:49 -0400
MIME-Version: 1.0
In-Reply-To: <55C0722C.7080904@metafoo.de>
References: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>
	<1437434050-32907-1-git-send-email-xander.huff@ni.com>
	<55B231DE.4080308@metafoo.de>
	<CAKfKVtGegy2P_YWQAtKEzByN-+q+bq=uus4zNvO4sghXRjpGPQ@mail.gmail.com>
	<55C0722C.7080904@metafoo.de>
Date: Fri, 7 Aug 2015 09:25:48 +0530
Message-ID: <CAKfKVtHPYqB1zjRad2=_xe9LEAuWs8PipNHHC5eUfW=XwChT2A@mail.gmail.com>
Subject: Re: [PATCH v3] iio: adc: xilinx-xadc: Push interrupts into threaded context
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Xander Huff <xander.huff@ni.com>, jic23@kernel.org,
	bigeasy@linutronix.de, knaack.h@gmx.de,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	joe.hershberger@ni.com, joshc@ni.com, nathan.sullivan@ni.com,
	jaeden.amero@ni.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 4, 2015 at 1:35 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> Well there is no need to use a threaded IRQ. The interrupt handler is quite
> small and doesn't take too much time and doesn't have any delays or sleeps
> in it either.
>
>
Ok thanks for the explanation.
