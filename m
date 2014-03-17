Return-Path: <giometti@enneenne.com>
Date: Mon, 17 Mar 2014 15:00:56 +0100
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>
Message-ID: <20140317140056.GX21643@enneenne.com>
References: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395064628-644-16-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395064628-644-16-git-send-email-alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2 15/15] ARM: at91/dt: at91-cosino_mega2560 remove
 useless tsadcc node
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 17, 2014 at 02:57:08PM +0100, Alexandre Belloni wrote:
> The tsadcc node is useless as it doesn't refer to anything and the touchscreen
> is handled by the adc0 node.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Rodolfo Giometti <giometti@linux.it>

Acked.

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
