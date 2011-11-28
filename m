Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-216.synserver.de ([212.40.185.216]:1039 "HELO
	smtp-out-211.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1751801Ab1K1LHE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Nov 2011 06:07:04 -0500
Message-ID: <4ED36B93.5020703@metafoo.de>
Date: Mon, 28 Nov 2011 12:08:03 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Federico Vaga <federico.vaga@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Greg KH <greg@kroah.com>, Alessandro Rubini <rubini@gnudd.com>
Subject: Re: ZIO wiki analysis of IIO and why it doesn't meet there requirements
 [was Re: Industrial Input Output analysis]
References: <CAH5GJ0qTW_DwaAVhe6ZjGYg=1CPPVuQQn3biyg+2BuYHp1Hefw@mail.gmail.com> <4ED21960.1000002@kernel.org>
In-Reply-To: <4ED21960.1000002@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/27/2011 12:05 PM, Jonathan Cameron wrote:
> Hi All,
> 
> I'm posting this reply to linux-iio as it may cut down on the amount of
> repeated discussion and allow us to draw everyone relevant together.
> Please CC anyone relevant (I've just added Greg and Lars-Peter as they
> commented on the ZIO RFC and hence are probably at least vaguely
> interested.)
> 
> Federico asked me to comment on the zio wiki page analysing IIO a week
> or so ago.  I didn't get round to it until yesterday (was prompted to
> take the time to do it by their posting of the patch series).
> 
> Anyhow, my points below are intended more for discussion than anything
> else.  There are clearly things we can learn from each other and I
> suspect at some point the question of whether we can merge (or at least
> share some infrastructure) will come up so it is worth keeping that in
> mind as we go. Targets are different but there will clearly be a blurred
> region between the two!  There are strengths and weaknesses to both
> approaches so lets work out what they are and make sure we agree the facts.
> 
> Jonathan
> 
>> Hello Mr Cameron,
>>
>> I'm working on a new linux framework for data acquisition systems, ZIO.
>> The open hardware repository (http://www.ohwr.org/) hosts the ZIO
>> project at http://www.ohwr.org/projects/zio/.
>>
>> Before starting with this project I analyzed both COMEDI and IIO to
>> undestand if they comply with our requirements, and they don't. I'm glad
>> if you can read my analysis about IIO on the wiki page of the ZIO project,
>> and give me your opinion. There is not much documentation about IIO, so I
>> read the entire code to understand how it works; maybe I misunderstood
>> something and you can correct me where I'm wrong in my analysis.
>> Bear in mind that our main case are boards with mega-samples for second
>> and with a time-stamp precision of sub-nanoseconds. Data output is as
>> important as data input and we don't handle small sets of samples.
>>
>> I think that IIO is a good work (absolutely better the COMEDI) but it
>> doesn't meet with our requirements and is directed toward a different
>> target (small chips). The first time, I analyzed the IIO version within kernel
>> 2.6.38/39 and I really appreciate the improvements done about sysfs
>> centralization and channel organization, but there are some points
>> where I still disagree.
>>
>> The ZIO project is under development at this time, but we think that
>> we'll submit a patch in one or two weeks based on the linux next tree;
>> Greg K.H. suggests us to write also on the IIO mailing list when the ZIO
>> patch is submitted.
>>
>> PS: English is not my native language, so ... I'm sorry.
> Would you mind if I posted this to linux-iio as well?  It might save us
> all some time.  (If you don't mind and want to reply, then just cc the list)
> 
> Sorry I didn't get to this earlier. Things have been a bit manic for the
> last few weeks.
> 
> Anyhow, overview of IIO is mostly fair and accurate. Few minor comments
> though (particularly as you've now posted and received the predictable
> questions!)  Note some of these refer to changes we could make,
> obviously your consideration is based on what is there so they don't
> directly apply to the web page.
> 
> 1) Number of devices is currently limited at 256 entirely because it is
> considered rude to request many more devices than you actually expect to
> see.  Can up this the moment someone actually says they have a reason to
> do so.
> 
> 2) Output signal support is patchy and currently unbuffered, but there
> is some.  Agreed it is rubbish.  Analog Devices were putting some effort
> in on this front, but  I don't know what stage it reached.
> It wasn't of interest to me so wasn't in the early code.

Support for output buffers and trigger output is on my TODO list and will
probably work on it soon.

> 
> 3) I disagree with your analysis of meta data. We do not carry it with
> the main data streams precisely because it is unnecessary overhead.
> Userspace knows what it setup and what it read. (If your stream is not
> controlled from userspace then fair enough, you need meta data).
> The meta data is valid whenever the buffer is enabled and hence can be
> read once, out of band.

I agree, some of the metadata fields look like they should not be in there,
like minor, major, devicename, ....
As Jonathan says all this information is already available to the
application processing the datastream. And the only usecase for having the
metadata interleaved with the real data is that you just want to dump the
stream right onto storage without further processing.

> 
> 4) The reason for the weird 'fake' floating point (which I agree is
> clunky) is the enormous range of real values one sees.  Straight integer
> just doesn't give you enough space.  Hence we cheat and use
> those two integers with a variable definition of what they mean.
> It's all that we have found that works for the devices we have seen.
> It's a wierd world but I doubt you'll find a single integer works in
> all cases.  Microvolts is incidently not a very fine granularity at all.
> Some of the values we have are already in picovolts and there are
> nastier devices out there.
> 

I guess longterm we probably want something else for this anyway, since the
current method is quite limited in resolution which already results in
inaccuracies with the devices we have today.

> [...]
> 
> Bits and bobs from your table at the end.  Note some of these are
> considerations of how we could adapt the code to make it fit your
> usecase better.
> 
> Buffers only currently work on a sample by sample basis. Technically
> there is nothing stopping us from adding a 'push lots' optional
> callback.  Getting this to interact well with the demux code needed for
> inkernel users would require an optional unroll into individual samples
> though.  This doesn't occur in the case where the buffer 'contains
> everything' that is captured.  Not too bad, but not pain free.  Kind of
> need this anyway to handle chaining a hardware buffer into a software
> buffer.
> 

I'm wondering how this bulk mode in ZIO works. Does the hardware simply
generate a bunch of samples after a trigger event, or do you have a buffer
inside the hardware and it periodically takes samples and you flush the
hardware buffer on a trigger event?

> [...]
> 
> Good point on the timestamp limitations. Easy to work around though, but
> making the special treatement of timestamps happen only if it is both a
> timestamp and not indexed.  Any 'real' channel should be indexed or have
> a modifier so this is valid.  Two line patch I think.  Only worth doing
> when there is a user though!

I wonder if it makes sense to add the concept of timestamp source. A
timestamp source would be associated with an trigger and whenever it is
triggered the timestamp would be read and made available for further
processing by the buffer. One timestamp source would be our nanosecond
clock, others could be generated by external hardware.

> 
> Anyhow, I will be interested to have a read of your proposed code.
> 
> The big difference I think are that you split data out into independent
> buffers, one per channel.  We use the concept of scan's because that is
> often how adcs actually work and cuts the overhead to minimum.  Two
> options and which is best is probably dictated by the use case.
> 
> Other big one is that our output support is currently minimal to say the
> least.
> 
> Will be interesting to compare.
> 

I still think that ZIO is just a subset of IIO. We do use IIO for high speed
data conversion.

The evaluation on the ZIO wiki reads a bit as if it is assumed that IIO is
set in stone. Though I think it should be possible to easily adopt it to the
ZIO needs. If we keep two different frameworks there will be a huge overlap
in functionality and also supported devices.

- Lars
