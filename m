Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.206]:49446 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdBCMKb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2017 07:10:31 -0500
Date: Fri, 3 Feb 2017 13:10:20 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: apw@canonical.com, joe@perches.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [RFC] Resolving "false positive" error message from checkpatch.pl
Message-ID: <20170203121020.GA8635@x220.localdomain>
References: <20170203101135.GA3663@x220.localdomain>
 <20170203102707.GA8330@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170203102707.GA8330@kroah.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Feb 03, 2017 11:27, Greg KH wrote:
> On Fri, Feb 03, 2017 at 11:11:35AM +0100, Slawomir Stepien wrote:
> > Hi all
> > 
> > There is a "false positive" error reported by checkpatch.pl:
> > 
> > ERROR: Use 4 digit octal (0777) not decimal permissions
> > #272: FILE: drivers/staging/iio/meter/ade7759.c:272:
> > +static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
> > +		ade7759_read_8bit,
> > +		ade7759_write_8bit,
> > +		ADE7759_CH1OS);
> > 
> > ERROR: Use 4 digit octal (0777) not decimal permissions
> > #276: FILE: drivers/staging/iio/meter/ade7759.c:276:
> > +static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
> > +		ade7759_read_8bit,
> > +		ade7759_write_8bit,
> > +		ADE7759_CH2OS);
> > 
> > The same for the file drivers/staging/iio/meter/ade7753.c.
> > 
> > We can see that this macro is matched by the pattern "IIO_DEV_ATTR_[A-Z_]+" from
> > @mode_permission_funcs in checkpatch.pl.
> > 
> > My question is: how this should be fixed?
> 
> Why do you think this is a false-positive?

Because the 1st arg of that macro is not supposed to be a permissions flags.

> > From what I can say, it's a false positive so the correct way to fix it is to
> > change the matching pattern: "IIO_DEV_ATTR_(?!CH_OFF)[A-Z_]+".
> 
> Huh?
> 
> Provide a patch to show what you are suggesting please.

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 8e96af53611c..0a1c6ec86caa 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -525,7 +525,7 @@ our @mode_permission_funcs = (
 	["debugfs_create_(?:file|u8|u16|u32|u64|x8|x16|x32|x64|size_t|atomic_t|bool|blob|regset32|u32_array)", 2],
 	["proc_create(?:_data|)", 2],
 	["(?:CLASS|DEVICE|SENSOR|SENSOR_DEVICE|IIO_DEVICE)_ATTR", 2],
-	["IIO_DEV_ATTR_[A-Z_]+", 1],
+	["IIO_DEV_ATTR_(?!CH_OFF)[A-Z_]+", 1],
 	["SENSOR_(?:DEVICE_|)ATTR_2", 2],
 	["SENSOR_TEMPLATE(?:_2|)", 3],
 	["__ATTR", 2],
-- 
2.11.0
