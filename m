Return-Path: <jic23@cam.ac.uk>
In-Reply-To: <11c2ea44-c03e-429f-80f3-875b57100267@email.android.com>
References: <0423FED8EB79934F939F077EAF96DBD717D8025F@HASMSX105.ger.corp.intel.com> <a761c167-aef3-42a3-a4bd-fa5078861dd1@email.android.com> <CE30B71206DDA24CBD6D43D23C236C034D8B11@HASMSX103.ger.corp.intel.com> <52160F47.2030403@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8BAA@HASMSX103.ger.corp.intel.com> <52161D55.8090201@metafoo.de> <CE30B71206DDA24CBD6D43D23C236C034D8BDE@HASMSX103.ger.corp.intel.com> <521625C5.4020504@metafoo.de> <52162987.501@jic23.retrosnub.co.uk> <CE30B71206DDA24CBD6D43D23C236C034D8C22@HASMSX103.ger.corp.intel.com> <09a07412-809b-491d-8c90-55003f6bfbf9@email.android.com> <CE30B71206DDA24CBD6D43D23C236C034D8C7C@HASMSX103.ger.corp.intel.com> <11c2ea44-c03e-429f-80f3-875b57100267@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: working with IIO
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Fri, 23 Aug 2013 19:37:35 +0100
To: Jonathan Cameron <jic23@kernel.org>,"Drubin, Daniel" <daniel.drubin@intel.com>,Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,Lars-Peter Clausen <lars@metafoo.de>
CC: "Yuniverg, Michael" <michael.yuniverg@intel.com>,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,"Haimovich, Yoav" <yoav.haimovich@intel.com>
Message-ID: <0e21c860-dede-448a-8c1a-1c0f23dc126e@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Jonathan Cameron <jic23@kernel.org> wrote:
>
>
>"Drubin, Daniel" <daniel.drubin@intel.com> wrote:
>>[...]
>>>  Not for replicating the
>>> >same mmap()ed data for multiple clients of course, but IIRC yes,
>v4l
>>> >allows multiple channels to be opened. E.g. for peeking full video,
>>> >preview and teletext or for switching between video sources on the
>>same
>>> >grabber. Making the whole major node singleton is a bit harsh
>>> >restriction IMHO.
>>> Sure to that but here equivalent is opening main stream an pulling
>>out
>>> different frame rates. Equivalent of your example is a multiple
>>sample rate
>>> hardware device. Those are handled using multiple instances of
>>iio_Dev.
>>
>>We actually considered creating a separate iio_dev per "virtual"
>sensor
>>(pair of {sensor, rate}). The problem is, they can pop-up dynamically
>>and even if we opened a backdoor interface of silently creating new
>>chardevs, we can't eat up all major numbers in the system. And we can
>>get dangerously close to that :-(
>
>Not a problem as can create anonymous ones like we already do for
>events.
>
>Now how you control which channels go where is harder as normally we do
>this sysfs and I would be very dubious about changing that.  It could
>obviously be done but I can't think of a clean way of doing it.
>
>Just how many readers are we talking?

Note I agree with Lars that this probably better done in user space. I just find the idea of doing it in kernel space interesting!
>>
>>Best regards,
>>Daniel
>>
>>---------------------------------------------------------------------
>>Intel Israel (74) Limited
>>
>>This e-mail and any attachments may contain confidential material for
>>the sole use of the intended recipient(s). Any review or distribution
>>by others is strictly prohibited. If you are not the intended
>>recipient, please contact the sender and delete all copies.
>>N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r��z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�m

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
