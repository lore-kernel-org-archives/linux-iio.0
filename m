Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E4BEBFD.3040004@cam.ac.uk>
Date: Wed, 17 Aug 2011 17:27:41 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 greg@kroah.com
Subject: Re: [RFC PATCH 0/2] Sysfs group create for empty groups.
References: <1313576222-27743-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313576222-27743-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/17/11 11:17, Jonathan Cameron wrote:
> The following is a quick stab at avoiding a hideous work around
> we are currently using in IIO.  In some cases we have entire
> attribute groups that are created from descriptions an array
> of struct iio_chan_spec.  To keep the reference counts sane
> and cause subdirectories to be created we are currently using
> dummy groups and dummy attribute arrays (provided once in the
> core).  This series is an initial probably stupid approach
> to avoiding this.
> 
> Greg has expressed some doubts about whether subdirectories are
> ever a good idea, but the problem occurs for the top level
> directory as well (handled by patch 1).
> 
> Note, all attributes are created at probe time.  Ultimately we
> are just respinning the create_group code to allow us to create
> the attributes from a device description rather than statically
> allocating them in each driver (results in a massive reduction
> in repeated code).
> 
> All opinions welcomed.
> 
> (this is definitely an rfc, the code isn't even tested yet)
Now tested and looks fine, so I've pushed it to our iio dev tree
(which is re based a few times a day currently so I can always
drop it again ;)
> 
> Jonathan
> 
> p.s. Greg, sorry for pestering about this!
> 
> Jonathan Cameron (2):
>   sysfs: Allow for null group pointer in create_group
>   sysfs: Allow for groups with no attributes - grp->attrs = NULL.
> 
>  fs/sysfs/group.c |   28 +++++++++++++++++-----------
>  1 files changed, 17 insertions(+), 11 deletions(-)
> 
