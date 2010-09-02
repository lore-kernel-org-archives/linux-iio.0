Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:38289 "EHLO
	ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab0IBJ6e (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2010 05:58:34 -0400
Date: 02 Sep 2010 10:58:30 +0100
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: Andrew Chew <AChew@nvidia.com>
Cc: "'Barry.Song@analog.com'" <Barry.Song@analog.com>,
	"'linux-iio@vger.kernel.org'" <linux-iio@vger.kernel.org>
Subject: RE: IIO magnetometer attributes
Message-ID: <Prayer.1.3.3.1009021058300.3349@hermes-1.csi.cam.ac.uk>
In-Reply-To: <643E69AA4436674C8F39DCC2C05F763816B85AD094@HQMAIL03.nvidia.com>
References: <643E69AA4436674C8F39DCC2C05F763816B85AD08D@HQMAIL03.nvidia.com>
 <4C7E2DB6.9090104@cam.ac.uk>
 <643E69AA4436674C8F39DCC2C05F763816B85AD094@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sep 1 2010, Andrew Chew wrote:

>> The documentation had slipped until a large set of patches 
>> from Manuel Stahl
>> that Greg KH pulled into staging this morning.  Hopefully the 
>> code and docs
>> now match rather better!
>
> Where's the repository that you're talking about, that has this updated 
> documentation? I did a pull of the kernel.org .35 git, as well as 
> kernel.org's mainline, and don't see any updates to this documentation. 

staging-next at

http://git.kernel.org/?p=linux/kernel/git/gregkh/staging-next-2.6.git;a=shortlog;h=refs/heads/staging-next

It should turn up in the main linux-next tree within a day.

Doesn't look like Greg has pushed since he merged our patches though. I'd 
imagine they will turn up later today. Obviously documentation doesn't 
count as a critical fix so it is never going to go into a stable tree.

If you want them in the meantime, they can all be found in the list archive
at http://marc.info/?l=linux-iio&r=1&w=2




>  
> ----------------------------------------------------------------------------------- 
> This email message is for the sole use of the intended recipient(s) and 
> may contain confidential information. Any unauthorized review, use, 
> disclosure or distribution is prohibited. If you are not the intended 
> recipient, please contact the sender by reply email and destroy all 
> copies of the original message. 
> -----------------------------------------------------------------------------------

