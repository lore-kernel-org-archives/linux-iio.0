Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <563C736D.6050705@metafoo.de>
References: <1445614411-533-1-git-send-email-daniel.baluta@intel.com> <1445614411-533-2-git-send-email-daniel.baluta@intel.com> <20151106075008.GA30535@lst.de> <CAEnQRZBjy3jnNFA77nrY+3h93MsEqGMko4cicqMP-RHBhLx0UQ@mail.gmail.com> <563C736D.6050705@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="----790M4UI1O4W5CJ2OFB8RQ8YKP7D116"
Subject: Re: [PATCH v10 1/5] configfs: Allow dynamic group creation
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Fri, 06 Nov 2015 17:38:53 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,Daniel Baluta <daniel.baluta@intel.com>,Christoph Hellwig <hch@lst.de>,Andrew Morton <akpm@linux-foundation.org>,Jonathan Cameron <jic23@kernel.org>
CC: Joel Becker <jlbec@evilplan.org>,"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,linux-fsdevel@vger.kernel.org,Hartmut Knaack <knaack.h@gmx.de>,Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,"octavian.purdila@intel.com" <octavian.purdila@intel.com>,Paul Bolle <pebolle@tiscali.nl>,patrick.porlan@intel.com,Adriana Reus <adriana.reus@intel.com>,constantin.musca@intel.com,marten@intuitiveaerial.com,Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>,Peter Meerwald <pmeerw@pmeerw.net>,viro@zeniv.linux.org.uk
Message-ID: <A334FE9C-F187-4304-AA98-6A40347AF731@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

------790M4UI1O4W5CJ2OFB8RQ8YKP7D116
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8



On 6 November 2015 09:31:25 GMT+00:00, Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 11/06/2015 09:48 AM, Daniel Baluta wrote:
>> On Fri, Nov 6, 2015 at 9:50 AM, Christoph Hellwig <hch@lst.de> wrote:
>>> Is this going into 4.4 through the iio tree?  If not is there any
>chance
>>> to get it in through some other tree?  While we're not past the
>merge
>>> window is trivial new functionality that doesn't change code, and
>I'd like to
>>> move existing configfs users over to it ASAP, so getting it into a
>baseline
>>> tree ASAP would be immensely helpful.
>> 
>> I think Jonathan could take this via linux-iio around Sunday.
>> 
>
>Since the IIO tree goes through the staging tree, which is already
>closed
>for 4.4, we won't be able to get it into 4.4 through the IIO tree. The
>whole
>configfs support for IIO will have to wait for 4.5.

Yup. I'd have no objection to a direct request to Linus to take this as a one off. 

Or we can do an immutable branch and pull it into all relevant subtrees so all
users can hit mainline all in 4.5 without waiting for a cycle. That tends to work well for bits like this.

Something odd going on with my email as I missed this version entirely. Will
investigate.  Reading up on the archive.

Jonathan
>
>> Could anyone do it faster :)? Andrew?
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
------790M4UI1O4W5CJ2OFB8RQ8YKP7D116
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<br>
<br>
On 6 November 2015 09:31:25 GMT+00:00, Lars-Peter Clausen &lt;lars@metafoo.de&gt; wrote:<br>
&gt;On 11/06/2015 09:48 AM, Daniel Baluta wrote:<br>
&gt;&gt; On Fri, Nov 6, 2015 at 9:50 AM, Christoph Hellwig &lt;hch@lst.de&gt; wrote:<br>
&gt;&gt;&gt; Is this going into 4.4 through the iio tree?  If not is there any<br>
&gt;chance<br>
&gt;&gt;&gt; to get it in through some other tree?  While we&#39;re not past the<br>
&gt;merge<br>
&gt;&gt;&gt; window is trivial new functionality that doesn&#39;t change code, and<br>
&gt;I&#39;d like to<br>
&gt;&gt;&gt; move existing configfs users over to it ASAP, so getting it into a<br>
&gt;baseline<br>
&gt;&gt;&gt; tree ASAP would be immensely helpful.<br>
&gt;&gt; <br>
&gt;&gt; I think Jonathan could take this via linux-iio around Sunday.<br>
&gt;&gt; <br>
&gt;<br>
&gt;Since the IIO tree goes through the staging tree, which is already<br>
&gt;closed<br>
&gt;for 4.4, we won&#39;t be able to get it into 4.4 through the IIO tree. The<br>
&gt;whole<br>
&gt;configfs support for IIO will have to wait for 4.5.<br>
<br>
Yup. I&#39;d have no objection to a direct request to Linus to take this as a one off. <br>
<br>
Or we can do an immutable branch and pull it into all relevant subtrees so all<br>
users can hit mainline all in 4.5 without waiting for a cycle. That tends to work well for bits like this.<br>
<br>
Something odd going on with my email as I missed this version entirely. Will<br>
investigate.  Reading up on the archive.<br>
<br>
Jonathan<br>
&gt;<br>
&gt;&gt; Could anyone do it faster :)? Andrew?<br>
&gt;--<br>
&gt;To unsubscribe from this list: send the line &quot;unsubscribe linux-iio&quot; in<br>
&gt;the body of a message to majordomo@vger.kernel.org<br>
&gt;More majordomo info at  <a href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a><br>
<br>
-- <br>
Sent from my Android device with K-9 Mail. Please excuse my brevity.
------790M4UI1O4W5CJ2OFB8RQ8YKP7D116--
