Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald <pmeerw@pmeerw.net>, Daniel Baluta <daniel.baluta@intel.com>, Haneen
 Mohammed <hamohammed.sa@gmail.com>, Matt Ranostay <mranostay@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>, Darshana Padmadas
	<darshanapadmadas@gmail.com>, Martin Fuzzey <mfuzzey@parkeon.com>, Octavian
 Purdila <octavian.purdila@intel.com>, Vladimir Barinov
	<vladimir.barinov@cogentembedded.com>, Crt Mori <cmo@melexis.com>, Masanari
 Iida <standby24x7@gmail.com>, Harald Geyer <harald@ccbib.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Michal Simek
	<michal.simek@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?=
	<soren.brinkmann@xilinx.com>, Kevin Tsai <ktsai@capellamicro.com>, Cristina
 Opriceana <cristina.opriceana@gmail.com>, Krzysztof Kozlowski
	<k.kozlowski@samsung.com>, Markus Pargmann <mpa@pengutronix.de>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, Bastien Nocera
	<hadess@hadess.net>, Antonio Ospite <ao2@ao2.it>, Vlad Dogaru
	<vlad.dogaru@intel.com>, Ana Calinov <ana.calinov@gmail.com>, Adriana Reus
	<adriana.reus@intel.com>, Joachim Eastwood <manabian@gmail.com>, Martin
 Kepplinger <martink@posteo.de>, Christoph Muellner
	<christoph.muellner@theobroma-systems.com>, Roberta Dobrescu
	<roberta.dobrescu@gmail.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Naidu Tellapati
	<naidu.tellapati@imgtec.com>, Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Marc Titinger <mtitinger@baylibre.com>, Fugang Duan <b38611@freescale.com>,
	Stefan Agner <stefan@agner.ch>, Sanchayan Maity <maitysanchayan@gmail.com>,
	kbuild test robot <fengguang.wu@intel.com>, Bhuvanchandra DV
	<bhuvanchandra.dv@toradex.com>, Lars Svensson
	<lars1.svensson@sonymobile.com>, Vladimirs Ambrosovs
	<rodriguez.twister@gmail.com>, Alan <gnomes@lxorguk.ukuu.org.uk>, Lucas De
 Marchi <lucas.demarchi@intel.com>, Viorel Suman <viorel.suman@gmail.com>,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>, Martin Liska
	<marxin.liska@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Markus Elfring
	<elfring@users.sourceforge.net>, Alexander Koch <mail@alexanderkoch.net>,
	Michael Hornung <mhornung.linux@gmail.com>, Felipe Balbi <balbi@ti.com>,
	Andreas Dannenberg <dannenberg@ti.com>, Tiberiu Breana
	<tiberiu.a.breana@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>, Marek Belisko
	<marek@goldelico.com>, Yong Li <sdliyong@gmail.com>, Tomasz Duszynski
	<tduszyns@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Ioana
 Ciornei <ciorneiioana@gmail.com>, Janani Ravichandran
	<janani.rvchndrn@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Tina Johnson
	<tinajohnson.1234@gmail.com>, Nizam Haider <nizamhaider786@gmail.com>,
	Shivani Bhardwaj <shivanib134@gmail.com>, Gregor Boirie
	<gregor.boirie@parrot.com>
Subject: [PATCH v5 1/2] timekeeping: export get_monotonic_coarse64 symbol
Date: Wed, 9 Mar 2016 19:05:48 +0100
Message-ID: <563d239fb3021ddf312349a5763fdca0a72b827b.1457546125.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1457546125.git.gregor.boirie@parrot.com>
References: <cover.1457546125.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

EXPORT_SYMBOL() get_monotonic_coarse64 for new IIO timestamping clock
selection usage. This provides user apps the ability to request a
particular IIO device to timestamp samples using a monotonic coarse clock
granularity.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 kernel/time/timekeeping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 34b4ced..5a95d41 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1950,6 +1950,7 @@ struct timespec64 get_monotonic_coarse64(void)
 
 	return now;
 }
+EXPORT_SYMBOL(get_monotonic_coarse64);
 
 /*
  * Must hold jiffies_lock
-- 
2.1.4
