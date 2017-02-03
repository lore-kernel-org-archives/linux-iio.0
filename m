Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0056.hostedemail.com ([216.40.44.56]:33013 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752531AbdBCMqj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2017 07:46:39 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 7E1305DDC9
        for <linux-iio@vger.kernel.org>; Fri,  3 Feb 2017 12:39:40 +0000 (UTC)
Message-ID: <1486125576.22276.61.camel@perches.com>
Subject: Re: [RFC] Resolving "false positive" error message from
 checkpatch.pl
From: Joe Perches <joe@perches.com>
To: Slawomir Stepien <sst@poczta.fm>,
        Greg KH <gregkh@linuxfoundation.org>
Cc: apw@canonical.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Date: Fri, 03 Feb 2017 04:39:36 -0800
In-Reply-To: <20170203121020.GA8635@x220.localdomain>
References: <20170203101135.GA3663@x220.localdomain>
         <20170203102707.GA8330@kroah.com> <20170203121020.GA8635@x220.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2017-02-03 at 13:10 +0100, Slawomir Stepien wrote:
> On Feb 03, 2017 11:27, Greg KH wrote:
> > On Fri, Feb 03, 2017 at 11:11:35AM +0100, Slawomir Stepien wrote:
> > > Hi all
> > > 
> > > There is a "false positive" error reported by checkpatch.pl:
> > > 
> > > ERROR: Use 4 digit octal (0777) not decimal permissions
> > > #272: FILE: drivers/staging/iio/meter/ade7759.c:272:
> > > +static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
> > > +		ade7759_read_8bit,
> > > +		ade7759_write_8bit,
> > > +		ADE7759_CH1OS);
> > > 
> > > ERROR: Use 4 digit octal (0777) not decimal permissions
> > > #276: FILE: drivers/staging/iio/meter/ade7759.c:276:
> > > +static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
> > > +		ade7759_read_8bit,
> > > +		ade7759_write_8bit,
> > > +		ADE7759_CH2OS);
> > > 
> > > The same for the file drivers/staging/iio/meter/ade7753.c.
> > > 
> > > We can see that this macro is matched by the pattern "IIO_DEV_ATTR_[A-Z_]+" from
> > > @mode_permission_funcs in checkpatch.pl.
> > > 
> > > My question is: how this should be fixed?
> > 
> > Why do you think this is a false-positive?
> 
> Because the 1st arg of that macro is not supposed to be a permissions flags.
> 
> > > From what I can say, it's a false positive so the correct way to fix it is to
> > > change the matching pattern: "IIO_DEV_ATTR_(?!CH_OFF)[A-Z_]+".
> > 
> > Huh?
> > 
> > Provide a patch to show what you are suggesting please.
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 8e96af53611c..0a1c6ec86caa 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -525,7 +525,7 @@ our @mode_permission_funcs = (
>  	["debugfs_create_(?:file|u8|u16|u32|u64|x8|x16|x32|x64|size_t|atomic_t|bool|blob|regset32|u32_array)", 2],
>  	["proc_create(?:_data|)", 2],
>  	["(?:CLASS|DEVICE|SENSOR|SENSOR_DEVICE|IIO_DEVICE)_ATTR", 2],
> -	["IIO_DEV_ATTR_[A-Z_]+", 1],
> +	["IIO_DEV_ATTR_(?!CH_OFF)[A-Z_]+", 1],
>  	["SENSOR_(?:DEVICE_|)ATTR_2", 2],
>  	["SENSOR_TEMPLATE(?:_2|)", 3],
>  	["__ATTR", 2],

There are many local MODE_DEV_ATTR_<foo> functions
that don't have permission in as the first argument.

$ grep -rPoh --include=*.[ch] "\bIIO_DEV_ATTR_[A-Z_]+\b" *|sort|uniq|wc -l
123

Maybe it'd be better to list the ones that do
or to change the argument order of the defines
and uses so mode _is_ the first argument.

$ grep -rPoh --include=*.[ch] "\bIIO_DEV_ATTR_[A-Z_]+\b" *|sort|uniq| \
  while read line ; do git grep -w $line | grep -w define ; done|grep _mode | grep -v "(_mode"
drivers/staging/iio/meter/meter.h:#define IIO_DEV_ATTR_CH_OFF(_num, _mode, _show, _store, _addr)		\
drivers/staging/iio/frequency/dds.h:#define IIO_DEV_ATTR_FREQ(_channel, _num, _mode, _show, _store, _addr)	\
drivers/staging/iio/frequency/dds.h:#define IIO_DEV_ATTR_FREQSYMBOL(_channel, _mode, _show, _store, _addr)	\
drivers/staging/iio/frequency/dds.h:#define IIO_DEV_ATTR_OUT_ENABLE(_channel, _mode, _show, _store, _addr)	\
drivers/staging/iio/frequency/dds.h:#define IIO_DEV_ATTR_PHASE(_channel, _num, _mode, _show, _store, _addr)	\
drivers/staging/iio/frequency/dds.h:#define IIO_DEV_ATTR_PHASESYMBOL(_channel, _mode, _show, _store, _addr)	\
drivers/staging/iio/frequency/dds.h:#define IIO_DEV_ATTR_PINCONTROL_EN(_channel, _mode, _show, _store, _addr)\
drivers/staging/iio/frequency/dds.h:#define IIO_DEV_ATTR_PINCONTROL_FREQ_EN(_channel, _mode, _show, _store, _addr)\
drivers/staging/iio/frequency/dds.h:#define IIO_DEV_ATTR_PINCONTROL_PHASE_EN(_channel, _mode, _show, _store, _addr)\

