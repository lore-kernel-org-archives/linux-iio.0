Return-Path: <SRS0=Rb5u=CX=gmail.com=vilhelm.gray@kernel.org>
Date: Sat, 25 Nov 2017 09:30:18 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Andreas Klinger <ak@it-klinger.de>
Subject: Re: [PATCH] MAINTAINERS: Add missing IIO ABI entries
Message-ID: <20171125143018.GA23670@sophia>
References: <af37130bfebe4424156f6f1c86a000d7d2dc3e0d.1511601745.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <af37130bfebe4424156f6f1c86a000d7d2dc3e0d.1511601745.git.lukas@wunner.de>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Nov 25, 2017 at 10:27:19AM +0100, Lukas Wunner wrote:
>Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
>Cc: Lars-Peter Clausen <lars@metafoo.de>
>Cc: Michael Hennerich <Michael.Hennerich@analog.com>
>Cc: Andreas Klinger <ak@it-klinger.de>
>Cc: Hartmut Knaack <knaack.h@gmx.de>
>Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>Signed-off-by: Lukas Wunner <lukas@wunner.de>
>---
> MAINTAINERS | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 650aa0e0e9d8..0f8e17d99400 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -262,6 +262,7 @@ ACCES 104-QUAD-8 IIO DRIVER
> M:	William Breathitt Gray <vilhelm.gray@gmail.com>
> L:	linux-iio@vger.kernel.org
> S:	Maintained
>+F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
> F:	drivers/iio/counter/104-quad-8.c
> 
> ACCES PCI-IDIO-16 GPIO DRIVER

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
