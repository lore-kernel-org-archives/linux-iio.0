Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727565AbeJVRL3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Oct 2018 13:11:29 -0400
Date: Mon, 22 Oct 2018 10:53:50 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Herton R. Krzesinski" <herton@redhat.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/10] tools iio: Override CFLAGS assignments
Message-ID: <20181022085350.GE2452@krava>
References: <20181016150614.21260-1-jolsa@kernel.org>
 <20181016150614.21260-10-jolsa@kernel.org>
 <20181021132616.34e3bc95@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181021132616.34e3bc95@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Oct 21, 2018 at 01:26:34PM +0100, Jonathan Cameron wrote:
> On Tue, 16 Oct 2018 17:06:14 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > So user could specify outside CFLAGS values.
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to poke at them.

thanks,
jirka

> 
> Thanks
> 
> Jonathan
> 
> > 
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/iio/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> > index 332ed2f6c2c2..e22378dba244 100644
> > --- a/tools/iio/Makefile
> > +++ b/tools/iio/Makefile
> > @@ -12,7 +12,7 @@ endif
> >  # (this improves performance and avoids hard-to-debug behaviour);
> >  MAKEFLAGS += -r
> >  
> > -CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> > +override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> >  
> >  ALL_TARGETS := iio_event_monitor lsiio iio_generic_buffer
> >  ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
> 
