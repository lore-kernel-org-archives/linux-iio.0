Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34600 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933448AbcJSRKB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 13:10:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id 128so2980262pfz.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Oct 2016 10:10:01 -0700 (PDT)
Date: Thu, 20 Oct 2016 01:09:57 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de
Subject: Re: [PATCH] tools: iio: iio_generic_buffer: add -A to force-enable
 all channels
Message-ID: <20161019170953.GA2121@Socrates-DK>
References: <1476440319-11124-1-git-send-email-eraretuya@gmail.com>
 <alpine.DEB.2.02.1610172311510.31400@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1610172311510.31400@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Oct 17, 2016 at 11:15:53PM +0200, Peter Meerwald-Stadler wrote:
> 
> > If attribute/s is/are already enabled (by default or via scripts or
> > manual interaction), issuing -a will fail to enable the channels thereby
> > one has to manually disable the said attribute/s before proceeding with
> > auto-enabling.
> > 
> > Add a command-line option -A to force-activate all channels regardless
> > of their current state.
> 
> comments below
>  
> > Suggested-by: Alison Schofield <amsfield22@gmail.com>
> > Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> > ---
> >  tools/iio/iio_generic_buffer.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> > index f39c0e9..84c9888 100644
> > --- a/tools/iio/iio_generic_buffer.c
> > +++ b/tools/iio/iio_generic_buffer.c
> > @@ -247,6 +247,7 @@ void print_usage(void)
> >  	fprintf(stderr, "Usage: generic_buffer [options]...\n"
> >  		"Capture, convert and output data from IIO device buffer\n"
> >  		"  -a         Auto-activate all available channels\n"
> > +		"  -A         Force-activate ALL channels\n"
> >  		"  -c <n>     Do n conversions\n"
> >  		"  -e         Disable wait for event (new data)\n"
> >  		"  -g         Use trigger-less mode\n"
> > @@ -347,16 +348,22 @@ int main(int argc, char **argv)
> >  	int noevents = 0;
> >  	int notrigger = 0;
> >  	char *dummy;
> > +	int force = 0;
> 
> bool instead of int
> maybe force_autochannels
> 
> >  
> >  	struct iio_channel_info *channels = NULL;
> >  
> >  	register_cleanup();
> >  
> > -	while ((c = getopt_long(argc, argv, "ac:egl:n:N:t:T:w:", longopts, NULL)) != -1) {
> > +	while ((c = getopt_long(argc, argv, "aAc:egl:n:N:t:T:w:", longopts,
> > +		NULL)) != -1) {
> >  		switch (c) {
> >  		case 'a':
> >  			autochannels = AUTOCHANNELS_ENABLED;
> >  			break;
> > +		case 'A':
> > +			autochannels = AUTOCHANNELS_ENABLED;
> > +			force = 1;
> > +			break;
> >  		case 'c':
> >  			errno = 0;
> >  			num_loops = strtoul(optarg, &dummy, 10);
> > @@ -519,15 +526,15 @@ int main(int argc, char **argv)
> >  			"diag %s\n", dev_dir_name);
> >  		goto error;
> >  	}
> > -	if (num_channels && autochannels == AUTOCHANNELS_ENABLED) {
> > +	if ((num_channels && autochannels == AUTOCHANNELS_ENABLED) && !force) {
> 
> parenthesis not strictly required/needed
> the bracketing is inconsistent, when do you use parenthesis with && and 
> when not? I suggest to drop parenthesis
> 
> >  		fprintf(stderr, "Auto-channels selected but some channels "
> >  			"are already activated in sysfs\n");
> >  		fprintf(stderr, "Proceeding without activating any channels\n");
> >  	}
> >  
> > -	if (!num_channels && autochannels == AUTOCHANNELS_ENABLED) {
> > -		fprintf(stderr,
> > -			"No channels are enabled, enabling all channels\n");
> > +	if ((!num_channels && autochannels == AUTOCHANNELS_ENABLED) ||
> > +	    ((autochannels == AUTOCHANNELS_ENABLED) && force)) {
> > +		fprintf(stderr, "Enabling all channels\n");
> 
> as above
 
Thanks for the feedback. I submitted a patchset about these suggestions.
However, I cannot fully omit all extra parentheses on that part
otherwise the tool will not compile due to requiring parentheses around
'||'.

Eva
> >  
> >  		ret = enable_disable_all_channels(dev_dir_name, 1);
> >  		if (ret) {
> > 
> 
> -- 
> 
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)
