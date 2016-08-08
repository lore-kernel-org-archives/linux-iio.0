Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35585 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbcHHWXX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2016 18:23:23 -0400
Received: by mail-pf0-f171.google.com with SMTP id x72so123142906pfd.2
        for <linux-iio@vger.kernel.org>; Mon, 08 Aug 2016 15:23:23 -0700 (PDT)
Date: Mon, 8 Aug 2016 15:23:19 -0700
From: Brian Norris <briannorris@chromium.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Brian Norris <computersforpeace@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] iio: fix sched WARNING "do not call blocking ops when
 !TASK_RUNNING"
Message-ID: <20160808222317.GA13805@localhost>
References: <20160802011244.GA54171@google.com>
 <37ea974c-9ac6-5a40-0f0e-ee34ef605a08@metafoo.de>
 <20160802165732.GA3310@localhost>
 <9a6a7f54-0343-db74-57a2-9f747ae659cc@metafoo.de>
 <20160804082621.GA11331@localhost>
 <489632a0-9aaf-e63b-4b08-0fa724a06e28@metafoo.de>
 <20160804094113.GA25537@localhost>
 <8741ae27-2279-4615-7917-e3e3683e41fa@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8741ae27-2279-4615-7917-e3e3683e41fa@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lars,

On Thu, Aug 04, 2016 at 12:21:08PM +0200, Lars-Peter Clausen wrote:
> And then also drop the if (!indio_dev->info) at the beginning of the function.

I was poking through the usage of this ->info field, and it looks like
it's supposed to be protected by the 'info_exist_lock' lock, but that's
not being acquired here and in at least one other location. Is this
another bug?

Brian
