Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38657 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab3HVQPf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 22 Aug 2013 12:15:35 -0400
In-Reply-To: <CE30B71206DDA24CBD6D43D23C236C034D8C22@HASMSX103.ger.corp.intel.com>
References: <0423FED8EB79934F939F077EAF96DBD717D8025F@HASMSX105.ger.corp.intel.com> <a761c167-aef3-42a3-a4bd-fa5078861dd1@email.android.com> <CE30B71206DDA24CBD6D43D23C236C034D8B11@HASMSX103.ger.corp.intel.com> <52160F47.2030403@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8BAA@HASMSX103.ger.corp.intel.com> <52161D55.8090201@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8BDE@HASMSX103.ger.corp.intel.com> <521625C5.4020504@metafoo.de> <52162987.501@jic23.retrosnub.co.uk> <CE30B71206DDA24CBD6D43D23C236C034D8C22@HASMSX103.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: working with IIO
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 22 Aug 2013 17:15:29 +0100
To: "Drubin, Daniel" <daniel.drubin@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
	"Yuniverg, Michael" <michael.yuniverg@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Haimovich, Yoav" <yoav.haimovich@intel.com>
Message-ID: <09a07412-809b-491d-8c90-55003f6bfbf9@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



"Drubin, Daniel" <daniel.drubin@intel.com> wrote:
>[...]
>> Does v4l handle multiple video streams to userspace at different
>frame
>> rates?  That is what we are talking about here effectively.
>
>I actually mentioned v4l in context of mmap().
Fair enough. Indeed mmap support is a great feature as is splice support for other uses.
Honestly I was originally waiting for the tracing guys to produce the magic lockless ring buffer that does all of this.  Been a long time since I picked up on anything about that though!
 Not for replicating the
>same mmap()ed data for multiple clients of course, but IIRC yes, v4l
>allows multiple channels to be opened. E.g. for peeking full video,
>preview and teletext or for switching between video sources on the same
>grabber. Making the whole major node singleton is a bit harsh
>restriction IMHO.
Sure to that but here equivalent is opening main stream an pulling out different frame rates. Equivalent of your example is a multiple sample rate hardware device. Those are handled using multiple instances of iio_Dev.
>
>Best regards,
>Daniel
>---------------------------------------------------------------------
>Intel Israel (74) Limited
>
>This e-mail and any attachments may contain confidential material for
>the sole use of the intended recipient(s). Any review or distribution
>by others is strictly prohibited. If you are not the intended
>recipient, please contact the sender and delete all copies.
>N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r��z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�m

