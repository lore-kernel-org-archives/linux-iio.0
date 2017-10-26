Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48096 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932309AbdJZQEI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Oct 2017 12:04:08 -0400
Date: Thu, 26 Oct 2017 17:04:03 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Hans de Goede <hdegoede@redhat.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/accel/bmc150: Improve unlocking of a mutex in two
 functions
Message-ID: <20171026170403.0f04a759@archlinux>
In-Reply-To: <20171026165113.271dc1e1@archlinux>
References: <66d582a4-a77e-cd78-4215-49587ec2259e@users.sourceforge.net>
        <fb223eb2-ddab-396e-372e-e9496be8bf0f@redhat.com>
        <c32ea2ea-5961-6589-6b51-1184d9565a38@users.sourceforge.net>
        <6a2c614a-4d0d-f2d2-1689-4c67a2fc3eea@redhat.com>
        <20171026165113.271dc1e1@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 26 Oct 2017 16:51:13 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 25 Oct 2017 18:22:02 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
> > Hi,
> > 
> > On 25-10-17 18:15, SF Markus Elfring wrote:  
> > >> IMHO, if you do this, you should rework the function so that there is a single unlock call
> > >> at the end, not a separate one in in error label.    
> > > 
> > > Thanks for your update suggestion.
> > > 
> > > Does it indicate that I may propose similar source code adjustments
> > > in this software area?
> > > 
> > >     
> > >> Could e.g. change this:
> > >>
> > >>          ret = bmc150_accel_set_power_state(data, false);
> > >>          mutex_unlock(&data->mutex);
> > >>          if (ret < 0)
> > >>                  return ret;
> > >>
> > >>          return IIO_VAL_INT;
> > >> }
> > >>
> > >> To:
> > >>
> > >>          ret = bmc150_accel_set_power_state(data, false);
> > >>          if (ret < 0)
> > >>                  goto unlock;
> > >>
> > >>      ret = IIO_VAL_INT;    
> > 
> > If that is the only unlock in the function, then it is probably
> > best to keep things as is. In general gotos are considered
> > better then multiple unlocks, but not having either is even
> > better.
> > 
> >   
> > > How do you think about to use the following code variant then?
> > > 
> > > 	if (!ret)
> > > 		ret = IIO_VAL_INT;    
> > 
> > 
> > I believe the goto unlock variant and setting ret = IIO_VAL_INT;
> > directly above the unlock label variant is better, because that
> > way the error handling is consistent between all steps and if
> > another step is later added at the end, the last step will
> > not require modification.  
> I agree, setting ret = IIO_VAL_INT in the good path unconditionally
> is good.
> 
> However, it is not just the unlocking that would be nice to
> unify here.  The call to:
> 
> bmc150_accel_set_power_state(data, false);
> 
> occurs in both the final two error paths and the good path.  An
> additional label and appropriate gotos would clean that up
> as well.

Ah my mistake, that would involve 'eating' the first error so
isn't a good idea.  Ignore this one!

Jonathan

> 
> This driver also suffers from issues with racing against
> the buffer enable check and buffers being enabled like
> I mentioned in the other email.   Clearly more cases of
> that around than I realised!  Patches welcome or I'll suggest
> it as an outreachy cleanup task.
> 
> Jonathan
> 
> >   
> > >> unlock:
> > >>          mutex_unlock(&data->mutex);
> > >>
> > >>          return ret;
> > >> }
> > >>
> > >> And also use the unlock label in the other cases, this is actually
> > >> quite a normal pattern. I see little use in a patch like this if there
> > >> are still 2 unlock paths after the patch.    
> > > 
> > > How long should I wait for corresponding feedback before another small
> > > source code adjustment will be appropriate?    
> > 
> > That is hard to say. I usually just do a new version when I've time,
> > seldomly someone complains I should have waited longer for feedback
> > (when I'm quite quick) but usually sending out a new version as soon
> > as you've time to work on a new version is best, since if you wait
> > you may then not have time for the entire next week or so, at least
> > that is my experience :)  There is really no clear rule here.
> > 
> > Regards,
> > 
> > Hans
> >   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

