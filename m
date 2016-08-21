Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: fix sched WARNING "do not call blocking ops when
 !TASK_RUNNING"
To: Jonathan Cameron <jic23@kernel.org>,
 Brian Norris <briannorris@chromium.org>
References: <20160802011244.GA54171@google.com>
 <37ea974c-9ac6-5a40-0f0e-ee34ef605a08@metafoo.de>
 <20160802165732.GA3310@localhost>
 <9a6a7f54-0343-db74-57a2-9f747ae659cc@metafoo.de>
 <20160804082621.GA11331@localhost> <20160809001937.GA23658@google.com>
 <f1206fbd-3c04-32b5-a898-86c3248661d2@kernel.org>
 <ca1428a5-9fa2-2de1-0d09-85d6c02cbf34@metafoo.de>
 <7e9386ee-176d-6959-9950-6f4c967921e4@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Brian Norris <computersforpeace@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <02f8f093-9544-29b1-2e96-2a897053f916@metafoo.de>
Date: Sun, 21 Aug 2016 14:26:47 +0200
MIME-Version: 1.0
In-Reply-To: <7e9386ee-176d-6959-9950-6f4c967921e4@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 08/21/2016 01:21 PM, Jonathan Cameron wrote:
[...]
> I've applied to this to the fixes-togreg branch of iio.git
> 
> For now I haven't marked it for stable, purely because I'm not sure
> when the first 'problem' usage was introduced.  I'm happy to explicitly
> send a request for stable inclusion if anyone wants to track down
> which stable trees this is applicable to.
> 
> I've very low on time today (holiday catch up) so won't get to
> dig into it myself for a at least a few weeks.

The issue has been around for a bit longer, but the wait_woken()
infrastructure has only available since v3.19.
