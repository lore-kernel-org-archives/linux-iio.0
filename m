Return-Path: <tglx@linutronix.de>
Date: Wed, 9 Mar 2016 09:43:43 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
cc: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org,
    Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
    Peter Meerwald <pmeerw@pmeerw.net>,
    Daniel Baluta <daniel.baluta@intel.com>,
    Haneen Mohammed <hamohammed.sa@gmail.com>,
    Matt Ranostay <mranostay@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>,
    Darshana Padmadas <darshanapadmadas@gmail.com>,
    Martin Fuzzey <mfuzzey@parkeon.com>,
    Octavian Purdila <octavian.purdila@intel.com>,
    Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
    Crt Mori <cmo@melexis.com>, Masanari Iida <standby24x7@gmail.com>,
    Harald Geyer <harald@ccbib.org>,
    Michael Hennerich <Michael.Hennerich@analog.com>,
    Michal Simek <michal.simek@xilinx.com>,
    =?ISO-8859-15?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
    Kevin Tsai <ktsai@capellamicro.com>,
    Cristina Opriceana <cristina.opriceana@gmail.com>,
    Krzysztof Kozlowski <k.kozlowski@samsung.com>,
    Markus Pargmann <mpa@pengutronix.de>,
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
    Bastien Nocera <hadess@hadess.net>, Antonio Ospite <ao2@ao2.it>,
    Vlad Dogaru <vlad.dogaru@intel.com>, Ana Calinov <ana.calinov@gmail.com>,
    Adriana Reus <adriana.reus@intel.com>,
    Joachim Eastwood <manabian@gmail.com>,
    Martin Kepplinger <martink@posteo.de>,
    Christoph Muellner <christoph.muellner@theobroma-systems.com>,
    Roberta Dobrescu <roberta.dobrescu@gmail.com>,
    Mika Westerberg <mika.westerberg@linux.intel.com>,
    Naidu Tellapati <naidu.tellapati@imgtec.com>,
    Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
    Marc Titinger <mtitinger@baylibre.com>, Fugang Duan <b38611@freescale.com>,
    Stefan Agner <stefan@agner.ch>, Sanchayan Maity <maitysanchayan@gmail.com>,
    kbuild test robot <fengguang.wu@intel.com>,
    Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
    Lars Svensson <lars1.svensson@sonymobile.com>,
    Vladimirs Ambrosovs <rodriguez.twister@gmail.com>,
    Alan <gnomes@lxorguk.ukuu.org.uk>,
    Lucas De Marchi <lucas.demarchi@intel.com>,
    Viorel Suman <viorel.suman@gmail.com>,
    Gabriele Mazzotta <gabriele.mzt@gmail.com>,
    Martin Liska <marxin.liska@gmail.com>,
    Javier Martinez Canillas <javier@osg.samsung.com>,
    Bjorn Andersson <bjorn.andersson@sonymobile.com>,
    Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
    Markus Elfring <elfring@users.sourceforge.net>,
    Alexander Koch <mail@alexanderkoch.net>,
    Michael Hornung <mhornung.linux@gmail.com>, Felipe Balbi <balbi@ti.com>,
    Andreas Dannenberg <dannenberg@ti.com>,
    Tiberiu Breana <tiberiu.a.breana@intel.com>,
    Dan Carpenter <dan.carpenter@oracle.com>,
    Cristina Moraru <cristina.moraru09@gmail.com>,
    Marek Belisko <marek@goldelico.com>, Yong Li <sdliyong@gmail.com>,
    Tomasz Duszynski <tduszyns@gmail.com>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Ioana Ciornei <ciorneiioana@gmail.com>,
    Janani Ravichandran <janani.rvchndrn@gmail.com>,
    "Andrew F. Davis" <afd@ti.com>, Tina Johnson <tinajohnson.1234@gmail.com>,
    Nizam Haider <nizamhaider786@gmail.com>,
    Shivani Bhardwaj <shivanib134@gmail.com>
Subject: Re: [PATCH v4 1/1] iio:core: timestamping clock selection support
In-Reply-To: <56DB27E0.2020606@kernel.org>
Message-ID: <alpine.DEB.2.11.1603090943110.3657@nanos>
References: <cover.1456831161.git.gregor.boirie@parrot.com> <8941aa811dc1666757105d81eccd30aacdc474eb.1456831161.git.gregor.boirie@parrot.com> <56DB27E0.2020606@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Sat, 5 Mar 2016, Jonathan Cameron wrote:

> On 01/03/16 11:27, Gregor Boirie wrote:
> > Adds a new per-device sysfs attribute "current_timestamp_clock" to allow
> > userspace to select a particular POSIX clock for buffered samples and
> > events timestamping.
> > 
> > Following clocks, as listed in clock_gettime(2), are supported:
> > CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW,
> > CLOCK_REALTIME_COARSE, CLOCK_MONOTONIC_COARSE, CLOCK_BOOTTIME and
> > CLOCK_TAI.
> > 
> > Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> Life is never simple :
> 
> ERROR: "get_monotonic_coarse64" [drivers/iio/industrialio.ko] undefined!
> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> make[1]: *** [__modpost] Error 1
> 
> Which turns out to be because get_monotonic_coarse64 isn't available to modules...
> Can add an export to make it so, but that's a change that needs Thomas'
> approval (I think!)
> 
> Thomas, would it make sense to export get_monotonic_coarse64?

If you really need it, yes.
 
Thanks,

	tglx
